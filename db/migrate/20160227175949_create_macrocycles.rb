class CreateMacrocycles < ActiveRecord::Migration
  def change
    create_table :macrocycles do |t|
      t.string :name
      t.integer :length
      t.timestamps
    end
  end
end
