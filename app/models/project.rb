class Project < ActiveRecord::Base
  # associations
  belongs_to :user, :counter_cache => true

  # scopes
  default_scope :order => 'projects.name'

  # validations
  validates_presence_of :user, :name

  with_options :allow_blank => true do |u|
    u.validates_length_of :name, :description, :in => 1..255
    u.validates_uniqueness_of :name, :scope => :user_id, :case_sensitive => false
  end

  def to_s
    name
  end

  def github_url
    "http://github.com/#{user.github}/#{name}"
  end
end
