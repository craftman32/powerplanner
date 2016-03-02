class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.integer :microcycle_id
      t.string :workout_type
      t.timestamps
    end
  end
end
