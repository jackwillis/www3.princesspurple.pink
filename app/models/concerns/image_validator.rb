module ImageValidator
  extend ActiveSupport::Concern

  ACCEPTABLE_TYPES = %w[image/jpeg image/png].freeze

  class_methods do
    def validates_image(image_field, alt_text_field:)
      validate -> { acceptable_image(image_field) }

      if alt_text_field.present?
        validates alt_text_field, presence: true, if: -> { try(image_field).present? }
        validates alt_text_field, length: { maximum: 255 }
      end
    end
  end

  private

  def acceptable_image(image_field)
    image = try(image_field)
    return unless image.attached?

    unless image.byte_size <= 1.megabyte
      errors.add(image_field, 'must be less than 1 MB in size')
    end

    unless ACCEPTABLE_TYPES.include?(image.content_type)
      errors.add(image_field, "must have a content type of #{ACCEPTABLE_TYPES.to_sentence(two_words_connector: ' or ')}")
    end
  end
end
