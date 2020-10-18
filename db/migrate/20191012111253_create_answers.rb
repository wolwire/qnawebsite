class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :content
      t.string :picture
      t.integer :votes_rep, default: 0
      t.references :user, foreign_true: true
      t.belongs_to :question

      t.timestamps
    end
  end
end
