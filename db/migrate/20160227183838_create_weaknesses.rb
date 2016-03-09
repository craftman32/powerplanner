class CreateWeaknesses < ActiveRecord::Migration
  def change
    create_table :weaknesses do |t|
      t.string :name
      t.string :bodypart
      t.timestamps
    end
  end
end
