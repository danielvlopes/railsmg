class ChangeDefaultValueForAdmin < ActiveRecord::Migration
  def self.up
    change_column_default :users, :admin, false
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end

