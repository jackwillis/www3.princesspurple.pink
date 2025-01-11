class PrivacyPolicyDecorator < ApplicationDecorator
  delegate_all

  def effective_date
    object.effective_date.strftime('%B %-d, %Y')
  end

  def content
    object.content.html_safe
  end
end
