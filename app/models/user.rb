class User < ActiveRecord::Base
  # Authlogic
  acts_as_authentic do |config|
    config.validate_email_field = false
    config.validate_login_field = false
    config.validate_password_field = false
  end

  # Associations
  has_many :projects
  has_many :meetings

  # Validations
  validates_presence_of :name, :email

  with_options :allow_blank => true do |u|
    u.validates_length_of :name, :github, :in => 1..255
    # FIXME: u.validates_as_email :email
    u.validates_uniqueness_of :email, :github, :case_sensitive => false
    u.validates_length_of :password, :minimum => 6, :if => :require_password?
    u.validates_confirmation_of :password, :if => :require_password?
  end

  def to_s
    name
  end
end

