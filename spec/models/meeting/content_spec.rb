require 'spec_helper'

describe Meeting::Content do
  before do
    @meeting_content = Meeting::Content.make
  end

  # Database
  should_have_column :meeting_id, :type => :integer
  should_have_columns :name, :url, :type => :string
  should_have_index :meeting_id

  # Associations
  should_belong_to :meeting

  # Validations
  should_validate_presence_of :meeting, :name, :url

  with_options :allow_blank => true do |c|
    c.should_validate_length_of :name, :in => 1..255
    # FIXME: c.should_validate_as_uri :url
  end

  it 'table_name should be meeting_content' do
    Meeting::Content.table_name.should be_eql('meeting_content')
  end

  it 'to_s should return name' do
    @meeting_content.to_s.should be_eql(@meeting_content.name)
  end
end

