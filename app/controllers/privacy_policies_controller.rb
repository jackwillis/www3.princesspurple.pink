class PrivacyPoliciesController < ApplicationController
  def index
    @current_privacy_policy = PrivacyPolicy.current.decorate
  end
end
