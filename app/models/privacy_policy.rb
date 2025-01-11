class PrivacyPolicy < ApplicationRecord
  include Draper::Decoratable

  validates :version,         presence: true
  validates :effective_date,  presence: true
  validates :content,         presence: true

  scope :current, -> { order(effective_date: :desc).first }
end
