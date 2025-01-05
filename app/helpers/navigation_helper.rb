module NavigationHelper
  def navigation_tabs_with_active_state
    base_navigation_tabs.map do |tab_name, tab_data|
      tab_data[:active] = @active_navigation_tab == tab_name
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
