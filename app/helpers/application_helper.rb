module ApplicationHelper
  SITE_TITLE                  = 'Princess Purple Pink'
  DEFAULT_TAGLINE             = 'The World’s Leading #12 Source in Catboy News'
  DEFAULT_TAGLINE_ATTRIBUTION = 'Barack Obama'

  def site_title
    SITE_TITLE
  end

  def default_tagline
    DEFAULT_TAGLINE
  end

  def default_tagline_attribution
    DEFAULT_TAGLINE_ATTRIBUTION
  end

  def page_title
    # Return formatted title with subtitle if present, otherwise return title or default site title.
    subtitle = @subtitle.presence || content_for(:subtitle)
    return "#{subtitle} - #{SITE_TITLE}" if subtitle.present?

    @title.presence || content_for(:title).presence || SITE_TITLE
  end

  def page_tagline
    custom_tagline || DEFAULT_TAGLINE
  end

  def custom_tagline
    @tagline.presence || content_for(:tagline).presence
  end

  def page_tagline_attribution
    custom_tagline_attribution || DEFAULT_TAGLINE_ATTRIBUTION
  end

  def custom_tagline_attribution
    @tagline_attribution.presence || content_for(:tagline_attribution).presence
  end

  def navigation_tabs_with_active_state
    base_navigation_tabs.map do |tab_name, tab_data|
      tab_data[:active] = @active_navigation_tab == tab_name || current_page?(tab_data[:link])
      tab_data
    end
  end
  
  private
  
  def base_navigation_tabs
    {
      home:   { title: 'Home',  icon: '🏠', link: root_path },
      news:   { title: 'News',  icon: '📰', link: articles_path },
      write:  { title: 'Write', icon: '✏️', link: new_article_path }
    }
  end
end
