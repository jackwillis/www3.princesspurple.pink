class PrivacyPolicyDecorator < Draper::Decorator
  delegate_all

  def effective_date
    object.effective_date.strftime('%B %-d, %Y')
  end
end
