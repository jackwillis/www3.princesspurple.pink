module ApplicationHelper
  def site_title
    'Princess Purple Pink'
  end

  def navigation_items
    [
      { title: 'Home',    icon: '🏠', link: root_path },
      { title: 'Archive', icon: '🗃️', link: articles_path },
    ]
  end
end
