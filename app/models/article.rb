class Article < ApplicationRecord
  include ImageValidator

  enum :category, { news_article: 0, our_values: 1 }

  has_rich_text     :body
  has_one_attached  :featured_image

  validates         :title,         presence: true, uniqueness: true
  validates         :category,      presence: true
  validates         :body,          presence: true
  validates_image   :featured_image
end
