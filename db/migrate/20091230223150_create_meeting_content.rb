class CreateMeetingContent < ActiveRecord::Migration
  def self.up
    create_table :meeting_content do |t|
      t.references :meeting
      t.string :name
      t.string :url

      t.timestamps
    end

    add_index :meeting_content, :meeting_id
  end

  def self.down
    drop_table :meeting_content
  end
end

