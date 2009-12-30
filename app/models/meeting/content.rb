class Meeting::Content < ActiveRecord::Base
  # Table name
  set_table_name 'meeting_content'

  # Associations
  belongs_to :meeting

  # Validations
  validates_presence_of :meeting, :name, :url

  with_options :allow_blank => true do |c|
    c.validates_length_of :name, :in => 1..255
    # FIXME: c.validates_as_uri :url
  end

  def to_s
    name
  end
end

