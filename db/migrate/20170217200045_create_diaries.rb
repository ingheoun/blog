class CreateDiaries < ActiveRecord::Migration
  def change
    create_table :diaries do |t|
      t.date :date
      t.string :content

      t.timestamps null: false
    end
  end
end
