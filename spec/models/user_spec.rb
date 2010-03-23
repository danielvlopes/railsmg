require 'spec_helper'

describe User do
  # database
  should_have_columns :name, :github, :email, :crypted_password, :password_salt, :persistence_token,
                      :perishable_token, :city, :site, :twitter, :type => :string
  should_have_column  :projects_count, :default => 0, :type => :integer
  should_have_column  :using_ruby_since, :type => :integer
  should_have_column  :about, :type => :text
  should_have_columns :public_email, :active, :admin, :type => :boolean, :default => false

  should_have_indices :email, :persistence_token, :unique => true

  # scopes
  should_have_default_scope :order => 'users.name'

  should_have_named_scope :with_projects, :include => :projects, :order => 'users.name, projects.name'
  should_have_named_scope :active, :conditions => { :active => true }

  # associations
  should_have_many :projects, :meetings

  # validations
  should_validate_presence_of :name, :email, :city
  should_validate_length_of :password, :minimum => 6, :if => :require_password?
  should_validate_confirmation_of :password, :if => :require_password?

  with_options :allow_blank => true do |u|
    u.should_validate_length_of :name, :city, :github, :in => 1..255
    # TODO: remarkable fix: u.should_validate_uniqueness_of :email, :case_sensitive => false
    # TODO: remarkable fix: u.should_validate_uniqueness_of :github, :case_sensitive => false
  end

  should_allow_values_for :email, 'john@doe.com', 'john.doe@gmail.ru'
  should_not_allow_values_for :email, 'john@doe', 'john.doe'
  
  should_allow_values_for :github, 'john', 'jonh_doe', 'jonh0909'
  should_not_allow_values_for :github, 'jonhn doe', 'john.doe'

  it 'active should be on protected attributes' do
    User.protected_attributes.should include 'active'
    User.protected_attributes.should include 'admin'
  end

  it 'to_s should return name' do
    subject.name = 'Gabriel Sobrinho'
    subject.to_s.should eql 'Gabriel Sobrinho'
  end

  it 'github_url should return a valid github url' do
    subject.github = 'sobrinho'
    subject.github_url.should eql 'http://github.com/sobrinho'
  end

  it 'twitter_url should return a valid twitter url' do
    subject.twitter = 'sobrinho'
    subject.twitter_url.should eql 'http://twitter.com/sobrinho'
  end

  it 'fetch_projects! should fetch user projects' do
    user = User.make

    user.fetch_projects!
    user.projects.should have(18).records
  end
  
  it 'active! should set active as true' do
    user = User.make
    
    User.active!(user.perishable_token).should eql user

    user.reload
    user.active.should be true
  end
end
