module ImageValidator
  extend ActiveSupport::Concern

  class_methods do
    def validates_image(field)
      validate -> { acceptable_image(field) }
    end
  end

  private

  def acceptable_image(field)
    image = send(field)
    return unless image.attached?

    unless image.byte_size <= 1.megabyte
      errors.add(field, 'is too big. Must be less than 1 MB.')
    end

    acceptable_types = %w[image/jpeg image/png]
    unless acceptable_types.include?(image.content_type)
      errors.add(field, 'must be a JPEG or PNG.')
    end
  end
end
