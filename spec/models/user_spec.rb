require 'spec_helper'

describe User do
  before do
    @user = User.make
  end

  # Database
  should_have_columns :name, :github, :email, :crypted_password, :password_salt,
                      :persistence_token, :perishable_token, :type => :string
  should_have_column  :projects_count, :type => :integer, :default => 0
  should_have_indices :email, :persistence_token, :unique => true

  # Associations
  should_have_many :projects

  # Validations
  should_validate_presence_of :name, :email

  with_options :allow_blank => true do |u|
    u.should_validate_length_of :name, :github, :in => 1..255
    # FIXME: u.should_validate_as_email :email
    u.should_validate_uniqueness_of :email, :github, :case_sensitive => false
    u.should_validate_length_of :password, :minimum => 6, :if => :require_password?
    u.should_validate_confirmation_of :password, :if => :require_password?
  end

  it 'to_s should return name' do
    @user.to_s.should be_eql(@user.name)
  end
end

