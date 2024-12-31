module ApplicationHelper
  SITE_TITLE = 'Princess Purple Pink'.freeze
  DEFAULT_TAGLINE = '“The World’s Leading #12 Source in Catboy News” <small>— Barack&nbsp;Obama</small>'.html_safe.freeze

  def site_title
    SITE_TITLE
  end

  def page_title
    # Return formatted title with subtitle if present, otherwise return title or default site title.
    subtitle = @subtitle.presence || content_for(:subtitle)
    return "#{subtitle} - #{SITE_TITLE}" if subtitle.present?
  
    return @title.presence || content_for(:title).presence || SITE_TITLE
  end  

  def page_tagline
    @tagline || content_for(:tagline) || DEFAULT_TAGLINE
  end

  def navigation_items
    [
      { title: 'Home',    icon: '🏠', link: root_path },
      { title: 'Archive', icon: '🗃️', link: articles_path },
    ]
  end
end
