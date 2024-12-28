class AddCategoryToArticles < ActiveRecord::Migration[8.0]
  def change
    add_column :articles, :category, :integer, null: false
  end
end
