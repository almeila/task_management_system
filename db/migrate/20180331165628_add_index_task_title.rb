class AddIndexTaskTitle < ActiveRecord::Migration[5.1]
  def change
    add_index :tasks, :title
  end
end
