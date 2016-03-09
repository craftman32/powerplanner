class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.integer :microcycle_id
      t.string :workout_type
      t.date :workout_start_date
      t.timestamps
    end
  end
end
