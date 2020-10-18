class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :admin, default: false
      t.string :password_digest
      t.string :remember_digest
      t.boolean :activated, default: false
      t.string :activation_digest
      t.datetime :activated_at
      t.integer :reputation, default: 0
      t.index :email , unique: true
      t.string "reset_digest"
      t.datetime "reset_sent_at"
      t.timestamps
    end
  end
end
