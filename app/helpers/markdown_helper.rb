module MarkdownHelper
  def render_markdown(text)
    markdown_renderer.render(text.to_s).html_safe
  end

  private

  def markdown_renderer
    @markdown_renderer ||= Redcarpet::Markdown.new(
      Redcarpet::Render::HTML
    )
  end
end
