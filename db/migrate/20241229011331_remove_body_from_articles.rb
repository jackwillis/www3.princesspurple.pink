class RemoveBodyFromArticles < ActiveRecord::Migration[8.0]
  def change
    remove_column :articles, :body, :text
  end
end
