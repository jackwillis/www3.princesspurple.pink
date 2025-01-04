class PrivacyPoliciesController < ApplicationController
  before_action :set_article, only: %i[ show ]

  def show
    @privacy_policy = @privacy_policy.decorate
  end

  private

  def set_article
    date = params[:policy_date].presence
    @privacy_policy = PrivacyPolicy.find_by(date:)
    @privacy_policy ||= PrivacyPolicy.current
  end
end
