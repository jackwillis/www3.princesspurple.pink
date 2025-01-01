require 'application_system_test_case'

class ArticlesTest < ApplicationSystemTestCase
  setup do
    @article = Article.news_article.create!(title: 'hello world', body: 'sample text')
  end

  test 'visiting the index' do
    visit articles_url
    assert_selector 'h1', text: 'News Articles'
  end

  test 'should create article' do
    visit articles_url
    click_on 'Write'

    fill_in 'Title', with: "Something other than #{@article.title}"
    # Simulate typing into the Trix editor
    find('#article_body').set(@article.body)

    click_on 'Submit'
    assert_text 'Article was successfully created'
  end

  test 'should update Article' do
    visit article_url(@article)
    click_on 'Edit this article'

    fill_in 'Title', with: @article.title
    # Simulate typing into the Trix editor
    find('#article_body').set(@article.body)

    click_on 'Submit'
    assert_text 'Article was successfully updated'
  end

  test 'should destroy Article' do
    visit article_url(@article)
    click_on 'Destroy this article', match: :first
    assert_text 'Article was successfully destroyed'
  end
end
