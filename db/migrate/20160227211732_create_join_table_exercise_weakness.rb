class CreateJoinTableExerciseWeakness < ActiveRecord::Migration
  def change
    create_join_table :Exercises, :Weaknesses do |t|
      t.index [:exercise_id, :weakness_id]
      t.index [:weakness_id, :exercise_id]
    end
  end
end
