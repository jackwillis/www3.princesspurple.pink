class HomeController < ApplicationController
  def index
    @articles = Article.news_article
  end
end
