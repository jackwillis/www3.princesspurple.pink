class AddFieldsToArticles < ActiveRecord::Migration[8.0]
  def change
    remove_column :articles, :category, :integer

    # Step 1: Add columns without null constraints
    add_column :articles, :featured_image_alt_text, :string
    add_column :articles, :published_at, :date
    add_column :articles, :draft, :boolean, default: false

    # Step 2: Set default values for existing records
    reversible do |dir|
      dir.up do
        Article.reset_column_information
        Article.update_all(published_at: Date.current)  # Set today's date for existing records
        Article.update_all(draft: false)                # Set default to false for existing records
      end
    end

    # Step 3: Add null constraints after setting defaults
    change_column_null :articles, :published_at, false
    change_column_null :articles, :draft, false

    # Step 4: Add indices
    add_index :articles, :draft
    add_index :articles, :published_at
  end
end
