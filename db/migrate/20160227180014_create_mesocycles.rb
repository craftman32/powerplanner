class CreateMesocycles < ActiveRecord::Migration
  def change
    create_table :mesocycles do |t|
      t.integer :macrocycle_id
      t.timestamps
    end
  end
end
