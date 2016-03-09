class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :users, :weaknesses do |t|
       t.index [:user_id, :weakness_id]
       t.index [:weakness_id, :user_id]
    end
  end
end
