class PrivacyPoliciesController < ApplicationController
  before_action :set_privacy_policy, only: %i[ show ]

  def show
    @privacy_policy = @privacy_policy.decorate
  end

  private

  def set_privacy_policy
    effective_date = params[:effective_date].presence
    @privacy_policy = PrivacyPolicy.find_by(effective_date:)
    @privacy_policy ||= PrivacyPolicy.current
  end
end
