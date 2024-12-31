class RenameThumbnailToFeaturedImageInActiveStorage < ActiveRecord::Migration[8.0]
  def up
    # Rename `thumbnail` to `featured_image` for `Article` class in `active_storage_attachments`
    ActiveStorage::Attachment.where(name: 'thumbnail', record_type: 'Article').update_all(name: 'featured_image')
  end

  def down
    # Revert `featured_image` back to `thumbnail` for `Article` class in `active_storage_attachments`
    ActiveStorage::Attachment.where(name: 'featured_image', record_type: 'Article').update_all(name: 'thumbnail')
  end
end
