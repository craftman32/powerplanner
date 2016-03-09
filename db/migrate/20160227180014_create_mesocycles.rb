class CreateMesocycles < ActiveRecord::Migration
  def change
    create_table :mesocycles do |t|
      t.integer :macrocycle_id
      t.date :mesocycle_start_date
      t.timestamps
    end
  end
end
