class HomeController < ApplicationController
  def index
    @active_navigation_tab = :home
    @articles = Article.order(publication_date: :desc).decorate
  end
end
