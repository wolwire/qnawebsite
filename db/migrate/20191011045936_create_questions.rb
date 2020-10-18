class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :header
      t.text :content
      t.string :picture
      t.integer :votes_rep ,default: 0
      t.references :user , foreign_key: true, null:false
      t.timestamps
    end
  end
end
