class ArticleDecorator < Draper::Decorator
  delegate_all

  def author
    object.try(:author) || 'Anonymous'
  end

  def created_at
    object.created_at.strftime('%B %d, %Y')
  end

  def featured_image_thumbnail_tag
    image_source =
      if object.featured_image.attached?
        object.featured_image.variant(resize_to_fill: [ 300, 300 ])
      else
        '/images/95compy_resized_300x300.jpg'
      end

    h.image_tag(
      image_source,
      alt:    'Thumbnail',
      class:  'w-72 mx-auto sm:w-full object-cover rounded-md mb-4 shadow',
      height: 300,
      width:  300,
      loading: 'lazy'
    )
  end
end
