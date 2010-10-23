class ChangeUsernameToPermalinkInUser < ActiveRecord::Migration
  def self.up
    rename_column :users, :username, :permalink
  end

  def self.down
    rename_column :users, :permalink, :username
  end
end
