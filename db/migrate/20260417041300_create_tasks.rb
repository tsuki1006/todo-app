class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false, limit: 100
      t.boolean :completed, null: false, default: 0
      t.text :content
      t.datetime :deadline
      t.timestamps
    end
  end
end
