class RenamePublishedAtToPublicationDateInArticles < ActiveRecord::Migration[8.0]
  def change
    rename_column :articles, :published_at, :publication_date
  end
end
