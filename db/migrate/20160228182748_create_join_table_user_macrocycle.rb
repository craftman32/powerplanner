class CreateJoinTableUserMacrocycle < ActiveRecord::Migration
  def change
    create_join_table :users, :macrocycles do |t|
      t.index [:user_id, :macrocycle_id]
      t.index [:macrocycle_id, :user_id]
    end
  end
end
