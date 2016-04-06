class CreateExercisesEquipmentJoinTable < ActiveRecord::Migration
  def change
    create_join_table :exercises, :equipment do |t|
       t.index [:exercise_id, :equipment_id]
       t.index [:equipment_id, :exercise_id]
    end
  end
end
