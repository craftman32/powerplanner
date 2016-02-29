class CreateJoinTableExerciseVariation < ActiveRecord::Migration
  def change
    create_join_table :Exercises, :Variations do |t|
      t.index [:exercise_id, :variation_id]
      t.index [:variation_id, :exercise_id]
    end
  end
end
