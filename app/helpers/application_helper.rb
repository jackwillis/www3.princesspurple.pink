module ApplicationHelper
  SITE_TITLE = 'Princess Purple Pink'.freeze

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
    @tagline || content_for(:tagline) || content_for(:default_tagline)
  end

  def navigation_items
    [
      { title: 'Home',    icon: '🏠', link: root_path },
      { title: 'Archive', icon: '🗃️', link: articles_path },
    ]
  end
end
