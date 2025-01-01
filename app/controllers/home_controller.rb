class HomeController < ApplicationController
  def index
    @articles = Article.news_article

    @articles = @articles.to_a
    while 0 < @articles.size && @articles.size < 10
      @articles.concat(@articles)
    end
  end
end
