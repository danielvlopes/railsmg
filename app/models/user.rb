require 'open-uri'

class User < ActiveRecord::Base
  # Authlogic
  acts_as_authentic do |c|
    c.validate_email_field = false
    c.validate_login_field = false
    c.validate_password_field = false
    c.perishable_token_valid_for = 48.hours
  end

  # Associations
  has_many :projects
  has_many :meetings

  # Scopes
  default_scope :order => 'users.name'

  named_scope :with_projects, :include => :projects, :order => 'users.name, projects.name'
  named_scope :active, :conditions => { :active => true }
  
  # Attributes
  attr_protected :active

  # Validations
  validates_presence_of :name, :email, :city
  validates_length_of :password, :minimum => 6, :if => :require_password?
  validates_confirmation_of :password, :if => :require_password?

  with_options :allow_blank => true do |u|
    u.validates_length_of :name, :city, :github, :in => 1..255
    u.validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    u.validates_format_of :github, :with => /^[a-z_]+$/
    u.validates_uniqueness_of :email, :github, :case_sensitive => false
  end
  
  after_save :fetch_projects!
  # Fetch user projects using YAML API from Github
  def fetch_projects!
    self.projects.destroy_all # Destroy current user projects

    unless github.blank?
      result = YAML.load open("http://github.com/api/v2/yaml/repos/show/#{github}/")

      result['repositories'].each do |repository|
        self.projects.create! :name => repository[:name], :description => repository[:description]
      end

      true
    end
  rescue OpenURI::HTTPError
    false # user not found, ignore
  end

  after_create :deliver_signup_confirmation

  def deliver_signup_confirmation
    Notifier.deliver_signup_confirmation self
  end
  
  def to_s
    name
  end

  def github_url
    "http://github.com/#{github}"
  end
  
  def twitter_url
    "http://twitter.com/#{twitter}"
  end
  
  def email_with_name
    %{"#{name}" <#{email}>}
  end
  
  def self.active! perishable_token
    find_using_perishable_token!(perishable_token).tap do |user|
      user.update_attribute(:active, true) if user
    end
  end
  
end