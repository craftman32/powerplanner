class CreateMacrocycles < ActiveRecord::Migration
  def change
    create_table :macrocycles do |t|
      t.string :name
      t.text :description
      t.integer :length
      t.string :macrocycle_type
      t.string :created_by
      t.date :macrocycle_start_date
      t.timestamps
    end
  end
end
