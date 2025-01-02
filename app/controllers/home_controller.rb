class HomeController < ApplicationController
  def index
    @articles = Article.news_article.decorate
  end
end
