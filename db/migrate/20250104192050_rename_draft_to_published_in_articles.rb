class RenameDraftToPublishedInArticles < ActiveRecord::Migration[8.0]
  def up
    # Rename the column
    rename_column :articles, :draft, :published

    # Change the default value to false (not published)
    change_column_default :articles, :published, from: nil, to: false

    # Invert the boolean values for existing records
    Article.reset_column_information
    Article.update_all('published = NOT published')
  end

  def down
    # Revert the column rename
    rename_column :articles, :published, :draft

    # Revert the default value to nil
    change_column_default :articles, :draft, from: false, to: nil

    # Revert the boolean values for existing records
    Article.reset_column_information
    Article.update_all('draft = NOT draft')
  end
end
