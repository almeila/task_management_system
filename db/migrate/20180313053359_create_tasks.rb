class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.string :status
      t.datetime :end_period
      t.integer :position
      t.integer :user_id
      
      t.timestamps
    end
  end
end
