require 'open-uri'

class User < ActiveRecord::Base
  # plugins
  acts_as_authentic do |config|
    config.validate_email_field = false
    config.validate_login_field = false
    config.validate_password_field = false
    config.perishable_token_valid_for = 48.hours
  end

  # associations
  has_many :projects
  has_many :meetings

  # scopes
  default_scope :order => 'users.name'

  named_scope :with_projects, :include => :projects, :order => "#{quoted_table_name}.name, #{Project.quoted_table_name}.name"
  named_scope :active, :conditions => { :active => true }
  
  # attributes
  attr_protected :active, :admin

  # validations
  validates_presence_of :name, :email, :city
  validates_length_of :password, :minimum => 6, :if => :require_password?
  validates_confirmation_of :password, :if => :require_password?

  with_options :allow_blank => true do |u|
    u.validates_length_of :name, :city, :github, :in => 1..255
    u.validates_format_of :email, :with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i
    u.validates_format_of :github, :with => /^[a-z0-9_]+$/
    u.validates_uniqueness_of :email, :github, :case_sensitive => false
  end

  # callbacks
  after_save :fetch_github_projects!
  after_create :deliver_signup_confirmation

  def fetch_github_projects!
    projects.destroy_all

    if github?
      begin
        result = YAML.load(open("http://github.com/api/v2/yaml/repos/show/#{github}"))

         result['repositories'].each do |repository|
          projects.create! :name => repository[:name], :description => repository[:description]
        end
      rescue OpenURI::HTTPError
         # invalid github user, ignore
      end
    end
  end

  def deliver_signup_confirmation
    Notifier.deliver_signup_confirmation(self)
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
  
  def self.active!(perishable_token)
    find_using_perishable_token!(perishable_token).tap do |user|
      user.update_attribute(:active, true) if user
    end
  end
end
