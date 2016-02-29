class CreateMicrocycles < ActiveRecord::Migration
  def change
    create_table :microcycles do |t|
      t.integer :mesocycle_id
      t.timestamps
    end
  end
end
