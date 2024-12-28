class Article < ApplicationRecord
  enum :category, { news_article: 0, our_values: 1 }

  validates :title,     presence: true
  validates :category,  presence: true
  validates :body,      presence: true
end
