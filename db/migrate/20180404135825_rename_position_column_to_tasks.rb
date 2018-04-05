class RenamePositionColumnToTasks < ActiveRecord::Migration[5.1]
  def change
    rename_column :tasks, :position, :priority
  end
end
