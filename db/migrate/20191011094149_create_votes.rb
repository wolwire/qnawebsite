class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.boolean :vote ,default: nil
      t.references :votable, polymorphic: true
      t.belongs_to :user, foreign_key: true, null:false
    end
  end
end
