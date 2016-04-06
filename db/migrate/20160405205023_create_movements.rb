class CreateMovements < ActiveRecord::Migration
  def change
    create_table :movements do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
