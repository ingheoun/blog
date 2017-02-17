class CreateDiaries < ActiveRecord::Migration
  def change
    create_table :diaries do |t|
      t.date :date, default: Date.new
      t.string :content

      t.timestamps null: false
    end
  end
end
