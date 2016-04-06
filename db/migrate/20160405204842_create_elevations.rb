class CreateElevations < ActiveRecord::Migration
  def change
    create_table :elevations do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
