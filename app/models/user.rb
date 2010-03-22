require 'open-uri'

class User < ActiveRecord::Base
  # plugins
  acts_as_authentic do |c|
    c.validate_email_field = false
    c.validate_login_field = false
    c.validate_password_field = false
    c.perishable_token_valid_for = 48.hours
  end

  # associations
  has_many :projects
  has_many :meetings

  # scopes
  default_scope :order => 'users.name'

  named_scope :with_projects, :include => :projects, :order => 'users.name, projects.name'
  named_scope :active, :conditions => { :active => true }
  
  # attributes
  attr_protected :active, :admin

  # validations
  validates_presence_of :name, :email, :city
  validates_length_of :password, :minimum => 6, :if => :require_password?
  validates_confirmation_of :password, :if => :require_password?

  with_options :allow_blank => true do |u|
    u.validates_length_of :name, :city, :github, :in => 1..255
    u.validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    u.validates_format_of :github, :with => /^[a-z_0-9]+$/
    u.validates_uniqueness_of :email, :github, :case_sensitive => false
  end
  
  after_save :fetch_projects!

  # Fetch user projects from Github
  def fetch_projects!
    projects.destroy_all

    if github?
      result = YAML.load open("http://github.com/api/v2/yaml/repos/show/#{github}/")

       result['repositories'].each do |repository|
        projects.create! :name => repository[:name], :description => repository[:description]
      end
    end
  rescue OpenURI::HTTPError # user not found, ignore
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
    returning find_using_perishable_token!(perishable_token) do |user|
      user.update_attribute(:active, true) if user
    end
  end
end
