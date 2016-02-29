class CreateWorkoutSets < ActiveRecord::Migration
  def change
    create_table :workout_sets do |t|
      t.integer :rep_count
      t.float :weight
      t.integer :workout_id
      t.timestamps
    end
  end
end
