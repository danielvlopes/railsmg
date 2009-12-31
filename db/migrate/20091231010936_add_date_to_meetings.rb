class AddDateToMeetings < ActiveRecord::Migration
  def self.up
    add_column :meetings, :starts_at, :datetime
    add_column :meetings, :ends_at, :datetime
  end

  def self.down
    remove_columns :meetings, :starts_at, :ends_at
  end
end

