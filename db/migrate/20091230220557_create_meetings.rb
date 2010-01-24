class CreateMeetings < ActiveRecord::Migration
  def self.up
    create_table :meetings do |t|
      t.references :user
      t.string :name
      t.text :description
      t.string :video
      t.string :code
      t.string :slides
      t.date   :start_on

      t.timestamps
    end

    add_index :meetings, :user_id
  end

  def self.down
    drop_table :meetings
  end
end