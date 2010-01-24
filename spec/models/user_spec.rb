require 'spec_helper'

describe User do
  before do
    @user = User.make
  end

  # Database
  should_have_columns :name, :github, :email, :crypted_password, :password_salt,
                      :persistence_token, :perishable_token, :city, :type => :string
  should_have_column  :projects_count, :type => :integer, :default => 0
  should_have_indices :email, :persistence_token, :unique => true

  # Scopes
  should_have_default_scope :order => 'users.name'

  should_have_named_scope :with_projects, :include => :projects, :order => 'users.name, projects.name'
  should_have_named_scope :active, :conditions => { :active => true }

  # Associations
  should_have_many :projects
  should_have_many :meetings

  # Validations
  should_validate_presence_of :name, :email
  should_validate_length_of :password, :minimum => 6, :if => :require_password?
  should_validate_confirmation_of :password, :if => :require_password?

  with_options :allow_blank => true do |u|
    u.should_validate_length_of :name, :city, :github, :in => 1..255
    # FIXME: u.should_validate_as_email :email
    u.should_validate_uniqueness_of :email, :case_sensitive => false
    # FIXME: u.should_validate_uniqueness_of :github, :case_sensitive => false
  end

  should_allow_values_for :github, 'john', 'jonh_doe'
  should_not_allow_values_for :github, 'jonhn doe', 'john.doe'

  it 'active should be on protected attributes' do
    User.protected_attributes.should be_include 'active'
  end

  it 'to_s should return name' do
    @user.to_s.should be_eql(@user.name)
  end
  
  it 'active! should set active as true' do
    User.active!(@user.perishable_token).should be_eql @user
    @user.reload
    @user.active.should be_true
  end
end

