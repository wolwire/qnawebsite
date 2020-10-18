class CreateJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :tags, :questions do |t|
       t.index [:tag_id, :question_id ] , unique: true
    end
  end
end
