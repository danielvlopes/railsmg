class Project < ActiveRecord::Base
  # Associations
  belongs_to :user, :counter_cache => true

  # Scopes
  default_scope :order => 'projects.name'

  # Validations
  validates_presence_of :user, :name, :description

  with_options :allow_blank => true do |u|
    u.validates_length_of :name, :description, :in => 1..255
    u.validates_uniqueness_of :name, :scope => :user_id, :case_sensitive => false
  end

  def to_s
    name
  end
end

