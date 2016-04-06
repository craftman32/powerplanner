class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.text :description
      t.integer :bar_id
      t.integer :board_id
      t.integer :box_id
      t.integer :elevation_id
      t.integer :exercisemethod_id
      t.integer :machine_id
      t.integer :movement_id
      t.integer :position_id
      t.integer :reprange_id
      t.integer :tempo_id
      t.timestamps
    end
  end
end
