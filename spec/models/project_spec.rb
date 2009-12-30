require 'spec_helper'

describe Project do
  before do
    @project = Project.make
  end

  # Database
  should_have_columns :name, :description, :type => :string
  should_have_column :user_id, :type => :integer
  should_have_index :user_id

  # Associations
  should_belong_to :user, :class_name => 'User'

  # Validations
  should_validate_presence_of :user, :name, :description

  with_options :allow_blank => true do |u|
    u.should_validate_length_of :name, :description, :in => 1..255
    u.should_validate_uniqueness_of :name, :scope => :user_id, :case_sensitive => false
  end

  it 'to_s should return name' do
    @project.to_s.should be_eql(@project.name)
  end
end

