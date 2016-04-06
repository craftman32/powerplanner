class CreateExercisesTensionsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :exercises, :tensions do |t|
       t.index [:exercise_id, :tension_id]
       t.index [:tension_id, :exercise_id]
    end
  end
end
