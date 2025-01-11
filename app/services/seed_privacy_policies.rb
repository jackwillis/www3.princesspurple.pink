class SeedPrivacyPolicies
  PRIVACY_POLICY_FILES_PATTERN = Rails.root.join('policies/privacy/*.md')

  include MarkdownHelper

  def call
    logger.info("Processing files in #{PRIVACY_POLICY_FILES_PATTERN}")
    Dir.glob(PRIVACY_POLICY_FILES_PATTERN).each do |filename|
      process_file(filename)
    end
    logger.info("Finished processing files in #{PRIVACY_POLICY_FILES_PATTERN}")
  end

  private

  def process_file(filename)
    logger.info("Processing file #{filename}")
    content = File.read(filename)
    
    # Look for YAML front matter between --- delimiters at start of file
    # The regex pattern matches:
    # \A        - Start of string
    # ---\s*\n  - Opening --- delimiter followed by optional whitespace and newline
    # .*?       - Any content (non-greedy match)
    # ^(---\s*$\n?) - Closing --- delimiter on its own line
    front_matter_pattern = /\A(---\s*\n.*?\n?)^(---\s*$\n?)/m
    
    if content =~ front_matter_pattern
      # Extract and parse the YAML front matter section
      front_matter = YAML.safe_load($1, symbolize_names: true, permitted_classes: [Date])
      
      # Get the remaining markdown content after the front matter
      # by calculating offset using length of matched sections
      front_matter_end = $1.length + $2.length
      markdown_content = content[front_matter_end..-1]
    else
      logger.warn("Skipping file #{filename} - no valid YAML front matter found between --- delimiters")
      return
    end

    create_or_update_policy!(front_matter:, markdown_content:)
    logger.info("Finished processing file #{filename}")
  end

  def create_or_update_policy!(front_matter:, markdown_content:)
    policy = PrivacyPolicy.find_or_initialize_by!(
      version:        front_matter[:version],
      effective_date: front_matter[:date]
    )
    policy.content = render_markdown(markdown_content)
    
    if policy.new_record?
      logger.info("Creating new privacy policy version #{front_matter[:version]}")
    elsif policy.changed?
      logger.info("Updating existing privacy policy version #{front_matter[:version]}")
    else
      logger.info("Skipping existing privacy policy version #{front_matter[:version]}")
    end
    
    policy.save!
  end

  def logger
    @logger ||= Logger.new($stdout, progname: self.class.name)
  end
end
