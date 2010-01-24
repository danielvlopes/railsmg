require 'spec_helper'

describe Project do
  # database
  should_have_columns :name, :description, :type => :string
  should_have_column :user_id, :type => :integer
  should_have_index :user_id

  # associations
  should_belong_to :user, :counter_cache => true

  # scopes
  should_have_default_scope :order => 'projects.name'

  # validations
  should_validate_presence_of :user, :name

  with_options :allow_blank => true do |p|
    p.should_validate_length_of :name, :description, :in => 1..255
    # TODO: remarkable fix: p.should_validate_uniqueness_of :name, :scope => :user_id, :case_sensitive => false
  end

  it 'to_s should return name' do
    subject.name = 'Nome do Projeto'
    subject.to_s.should eql 'Nome do Projeto'
  end

  it 'github_url should return a valid github url' do
    subject.user = mock_model(User, :github => 'sobrinho')
    subject.name = 'projeto'

    subject.github_url.should eql 'http://github.com/sobrinho/projeto'
  end
end
