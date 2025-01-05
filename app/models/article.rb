class Article < ApplicationRecord
  include ImageValidator

  has_one_attached  :featured_image
  has_rich_text     :body

  validates         :title,               presence: true, uniqueness: true, length: { maximum: 255 }
  validates         :tagline,             length: { maximum: 255 }
  validates         :tagline_attribution, length: { maximum: 255 }
  validates_image   :featured_image,      alt_text_field: :featured_image_alt_text
  validates         :body,                presence: true
  validates         :published,           inclusion: { in: [ true, false ] }
  validates         :publication_date,    presence: true

  after_initialize  :set_defaults,        if: :new_record?

  scope             :published,           -> { where(published: true) }

  private

  def set_defaults
    self.published = false if self.published.nil?
    self.publication_date ||= Date.current
  end
end
