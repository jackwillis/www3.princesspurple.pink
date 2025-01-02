class MarkdownRenderer
  def self.render(text)
    markdown.render(text.to_s).html_safe
  end

  def self.markdown
    @markdown ||= Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      autolink: true,
      tables: true,
      fenced_code_blocks: true
    )
  end
end
