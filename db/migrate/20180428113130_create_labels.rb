class CreateLabels < ActiveRecord::Migration[5.1]
  def change
    create_table :labels do |t|
      t.string :name, null: false, unique: true
      t.integer :color, default: 0

      t.timestamps
    end
  end
end
