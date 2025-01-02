class HomeController < ApplicationController
  def index
    @articles = Article.limit(6).decorate
  end
end
