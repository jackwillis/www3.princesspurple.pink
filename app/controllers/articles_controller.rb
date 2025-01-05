class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  def index
    @active_navigation_tab = :news
    @articles = Article.order(publication_date: :desc).decorate
  end

  def show
    @active_navigation_tab = :news
    @article = @article.decorate
  end

  def new
    @active_navigation_tab = :write
    @article = Article.new
  end

  def edit
    @active_navigation_tab = :write
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy!
    redirect_to articles_path, notice: 'Article was successfully destroyed.', status: :see_other
  end

  private

  def set_article
    @article = Article.find(params.expect(:id))
  end

  def article_params
    params.expect(article: %i[
      title
      tagline
      tagline_attribution
      featured_image
      featured_image_alt_text
      body
      published
      publication_date
    ])
  end
end
