module ContentPreprocessorHelper
  TRANSFORMATIONS_REGEX = /
    \[dropcap\](?<dropcap_content>.*?)\[\/dropcap\] |
    \[youtube\s+id="(?<youtube_id>.*?)"\] |
    \[hr\s+style="(?<hr_style>.*?)"\]
  /x.freeze

  def render_enhanced_markdown(content)
    content.gsub(TRANSFORMATIONS_REGEX) do |match|
      case Regexp.last_match
      in { dropcap_content: content } if content
        render_dropcap(content)
      in { youtube_id: id } if id
        render_youtube(id)
      in { hr_style: style } if style
        render_custom_hr(style)
      else
        match
      end
    end.html_safe
  end

  private

  def render_dropcap(text)
    return '' if text.blank?

    initial = text[0]
    rest = text[1..]
    <<~HTML.strip
      <span class="drop-cap">
        <span class="drop-cap-initial">#{initial}</span>#{rest}
      </span>
    HTML
  end

  def render_youtube(video_id)
    return '' if video_id.blank?

    <<~HTML.strip
      <iframe
        class="youtube-embed"
        src="https://www.youtube.com/embed/#{video_id}"
        frameborder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        allowfullscreen
      ></iframe>
    HTML
  end

  def render_custom_hr(style = 'default-style')
    <<~HTML.strip
      <hr class="#{style}">
    HTML
  end
end
