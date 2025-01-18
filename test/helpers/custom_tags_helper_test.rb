require 'test_helper'

class CustomTagsHelperTest < ActionView::TestCase
  include CustomTagsHelper

  def test_render_dropcap
    result = render_dropcap('Once upon a time...')
    expected = "<span class=\"drop-cap\">\n  <span class=\"drop-cap-initial\">O</span>nce upon a time...\n</span>"
    assert_equal expected, result
  end

  def test_render_dropcap_with_blank_text
    result = render_dropcap('')
    assert_equal '', result
  end

  def test_render_youtube
    result = render_youtube('a1_B2c3')
    expected = <<~HTML.strip
      <iframe
        class="youtube-embed"
        src="https://www.youtube.com/embed/a1_B2c3"
        frameborder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        allowfullscreen
      ></iframe>
    HTML
    assert_equal expected, result
  end

  def test_render_youtube_with_blank_id
    result = render_youtube('')
    assert_equal '', result
  end

  def test_render_custom_hr
    result = render_custom_hr('fancy-style')
    expected = '<hr class="fancy-style">'
    assert_equal expected, result
  end

  def test_render_custom_hr_with_default_style
    result = render_custom_hr
    expected = '<hr class="default-style">'
    assert_equal expected, result
  end

  def test_render_custom_tags_with_all_transformations
    content = <<~MARKDOWN
      [dropcap]Once upon a time...[/dropcap]
      [youtube id="a1_B2c3"]
      [hr style="fancy-style"]
    MARKDOWN

    result = render_custom_tags(content)

    expected = <<~HTML
      <span class="drop-cap">
        <span class="drop-cap-initial">O</span>nce upon a time...
      </span>
      <iframe
        class="youtube-embed"
        src="https://www.youtube.com/embed/a1_B2c3"
        frameborder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        allowfullscreen
      ></iframe>
      <hr class="fancy-style">
    HTML

    assert_equal expected.strip, result.strip
  end

  def test_render_custom_tags_with_partial_transformations
    content = 'Here is a [dropcap]story[/dropcap] with a [hr style="default-style"].'
    result = render_custom_tags(content)

    expected = "Here is a <span class=\"drop-cap\">\n  <span class=\"drop-cap-initial\">s</span>tory\n</span> with a <hr class=\"default-style\">."
    assert_equal expected, result
  end

  def test_render_custom_tags_with_no_transformations
    content = 'This is a simple text with no custom tags.'
    result = render_custom_tags(content)
    assert_equal content, result
  end
end
