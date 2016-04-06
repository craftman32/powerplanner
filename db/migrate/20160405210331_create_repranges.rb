class CreateRepranges < ActiveRecord::Migration
  def change
    create_table :repranges do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
