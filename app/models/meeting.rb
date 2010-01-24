class Meeting < ActiveRecord::Base
  URL_REGEXP = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix

  # associations
  belongs_to :user

  # plugins
  has_attached_file :slide_preview, :styles => { :medium => "267x345>", :thumb => "116x150>" }

  # scopes
  default_scope :order => 'start_on DESC'

  # validations
  validates_presence_of :name, :description

  with_options :allow_blank => true do |m|
    m.validates_length_of :name, :in => 1..255
    m.validates_uniqueness_of :name, :scope => :user_id, :case_sensitive => false
    m.validates_format_of :slides, :video, :code, :with => URL_REGEXP
  end

  def to_s
    name
  end
end

