class PrivacyPolicyDecorator < Draper::Decorator
  delegate_all

  def effective_date
    "Effective #{object.date.strftime('%B %-d, %Y')}"
  end

  def content
    MarkdownRenderer.render(object.content)
  end
end
