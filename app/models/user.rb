require 'open-uri'

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

  # Scopes
  default_scope :order => 'users.name'
  named_scope :with_project, :include => :projects, :order => 'users.name, projects.name'

  # Validations
  validates_presence_of :name, :email, :city
  validates_length_of :password, :minimum => 6, :if => :require_password?
  validates_confirmation_of :password, :if => :require_password?

  with_options :allow_blank => true do |u|
    u.validates_length_of :name, :city, :github, :in => 1..255
    # FIXME: u.validates_as_email :email
    u.validates_format_of :github, :with => /^[a-z_]+$/
    u.validates_uniqueness_of :email, :github, :case_sensitive => false
  end

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

  def to_s
    name
  end
  
  def github_url
    "http://github.com/#{github}"
  end
  
  def twitter_url
    "http://twitter.com/#{twitter}"
  end
end

