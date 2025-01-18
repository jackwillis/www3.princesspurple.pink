# Helper module to preprocess content and replace custom tags
# (e.g., [dropcap], [youtube], [hr]) with corresponding HTML elements.
#
# Supported custom tags:
# - [dropcap]Once upon a[/dropcap]  -> Formats the first character as a drop cap.
# - [youtube id="video_id"]         -> Embeds a YouTube video.
# - [hr style="style_name"]         -> Inserts a custom-styled horizontal rule.
module CustomTagsHelper
  # Uses named captures to extract the content of each tag.
  TRANSFORMATIONS_REGEX = /
    \[dropcap\](?<dropcap_content>.*?)\[\/dropcap\] |
    \[youtube\s+id="(?<youtube_id>.*?)"\] |
    \[hr\s+style="(?<hr_style>.*?)"\]
  /x.freeze

  def render_custom_tags(content)
    content.gsub(TRANSFORMATIONS_REGEX) do |match|
      # In each match, we check each of the named captures.
      # If the capture is present, we render the corresponding HTML element.
      case Regexp.last_match
      in { dropcap_content: content } unless content.nil?
        render_dropcap(content)
      in { youtube_id: id } unless id.nil?
        render_youtube(id)
      in { hr_style: style } unless style.nil?
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
