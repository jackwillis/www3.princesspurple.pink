class PrivacyPolicyDecorator < Draper::Decorator
  delegate_all

  def effective_date
    "Super Effective #{object.date.strftime('%B %-d, %Y')}"
  end

  def content
    h.render_markdown(object.content)
  end
end
