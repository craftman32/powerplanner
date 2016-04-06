class CreateExercisemethods < ActiveRecord::Migration
  def change
    create_table :exercisemethods do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
