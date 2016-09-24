class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string "title"
      t.text "content"
      t.integer "hits"
      
      t.timestamps null: false
    end
  end
end
