class CreateTensions < ActiveRecord::Migration
  def change
    create_table :tensions do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
