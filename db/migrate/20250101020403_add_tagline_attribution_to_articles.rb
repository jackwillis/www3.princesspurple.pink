class AddTaglineAttributionToArticles < ActiveRecord::Migration[8.0]
  def change
    # Add tagline_attribution as a string
    add_column :articles, :tagline_attribution, :string
    
    # Rename banner_text column to tagline
    rename_column :articles, :banner_text, :tagline
  end
end
