class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :github
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :perishable_token
      t.integer :projects_count, :default => 0

      t.timestamps
    end

    add_index :users, :email, :unique => true
    add_index :users, :persistence_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end

