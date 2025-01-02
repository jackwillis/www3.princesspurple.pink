class PrivacyPolicy
  DATA_DIRECTORY = Rails.root.join('policies', 'privacy')

  include Draper::Decoratable

  attr_reader :date, :content

  def initialize(date:, content:)
    raise ArgumentError, 'date must be a Date' unless date.is_a?(Date)
    raise ArgumentError, 'content cannot be blank' if content.blank?
    
    @date = date
    @content = content
  end

  class << self
    def all
      policy_files.map { |file| read_policy_file(file) }.compact.sort_by(&:date)
    end

    def current
      latest_date = policy_files.map { |file| extract_date(file) }.compact.max
      find_by(date: latest_date) if latest_date
    end

    def find_by(date:)
      file_path = path_for_date(date)
      return unless File.exist?(file_path)
      content = File.read(file_path)
      new(date:, content:)
    end

    private

    def read_policy_file(file_path)
      date = extract_date(file_path)
      return unless policy_date
      content = File.read(file_path)
      new(date:, content:)
    end

    def policy_files
      Dir.glob(DATA_DIRECTORY.join('*.md'))
    end

    def extract_date(file_path)
      filename = File.basename(file_path, '.md')
      Date.parse(filename)
    rescue ArgumentError
      nil
    end

    def path_for_date(date)
      filename = date.strftime('%Y-%m-%d')
      DATA_DIRECTORY.join("#{filename}.md")
    end
  end
end
