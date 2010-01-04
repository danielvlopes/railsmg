class AddColumnsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :about, :text
    add_column :users, :site, :string
    add_column :users, :twitter, :string
    add_column :users, :using_ruby_since, :integer
    add_column :users, :public_email, :boolean, :default => false
  end

  def self.down
    remove_column :users, :public_email
    remove_column :users, :using_ruby_since
    remove_column :users, :twitter
    remove_column :users, :site
    remove_column :users, :about
  end
end
