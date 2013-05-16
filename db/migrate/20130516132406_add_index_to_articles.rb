class AddIndexToArticles < ActiveRecord::Migration
  def change
  	add_index(:articles, :title)
  	add_index(:articles, :id)
  end
end
