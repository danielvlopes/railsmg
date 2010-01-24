class AddAttachmentsSlidePreviewToMeeting < ActiveRecord::Migration
  def self.up
    add_column :meetings, :slide_preview_file_name, :string
    add_column :meetings, :slide_preview_content_type, :string
    add_column :meetings, :slide_preview_file_size, :integer
    add_column :meetings, :slide_preview_updated_at, :datetime
  end

  def self.down
    remove_column :meetings, :slide_preview_file_name
    remove_column :meetings, :slide_preview_content_type
    remove_column :meetings, :slide_preview_file_size
    remove_column :meetings, :slide_preview_updated_at
  end
end
