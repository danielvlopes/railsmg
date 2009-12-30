require 'spec_helper'

describe Meeting do
  before do
    @meeting = Meeting.make
  end

  # Database
  should_have_column :user_id, :type => :integer
  should_have_column :name, :type => :string
  should_have_column :description, :type => :text
  should_have_index :user_id

  # Associations
  should_belong_to :user

  # Validations
  should_validate_presence_of :user, :name, :description

  with_options :allow_blank => true do |m|
    m.should_validate_length_of :name, :in => 1..255
    m.should_validate_uniqueness_of :name, :scope => :user_id, :case_sensitive => false
  end

  it 'to_s should return name' do
    @meeting.name.should be_eql(@meeting.name)
  end
end

