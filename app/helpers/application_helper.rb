module ApplicationHelper
  SITE_TITLE                  = 'Princess Purple Pink'
  DEFAULT_TAGLINE             = 'The World’s Leading #12 Source in Catboy News'
  DEFAULT_TAGLINE_ATTRIBUTION = 'Barack Obama'

  include MarkdownHelper
  include NavigationHelper

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

  def attachment_persisted?(attachable)
    attachable.attached? && attachable.attachment.blob.present? && attachable.attachment.blob.persisted?
  end
end
