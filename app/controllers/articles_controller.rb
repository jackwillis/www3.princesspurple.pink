class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  def index
    @articles = Article.news_article

    @articles = @articles.to_a
    while 0 < @articles.size && @articles.size < 10
      @articles.concat(@articles)
    end
  end

  def show
    @tagline = @article.banner_text
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.news_article.new(article_params)

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
    params.expect(article: [ :title, :banner_text, :body, :category, :featured_image ])
  end
end
