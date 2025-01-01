require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.news_article.new(title: 'hello world', body: 'sample text')
  end

  test 'should get index' do
    get articles_url
    assert_response :success
  end

  test 'should get new' do
    get new_article_url
    assert_response :success
  end

  test 'should create article' do
    assert_difference('Article.count') do
      post articles_url, params: { article: { body: @article.body, title: @article.title } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test 'should show article' do
    @article.save!
    get article_url(@article)
    assert_response :success
  end

  test 'should get edit' do
    @article.save!
    get edit_article_url(@article)
    assert_response :success
  end

  test 'should update article' do
    @article.save!
    patch article_url(@article), params: { article: { body: @article.body, title: @article.title } }
    assert_redirected_to article_url(@article)
  end

  test 'should destroy article' do
    @article.save!
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end
end
