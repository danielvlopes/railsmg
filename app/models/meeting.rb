class Meeting < ActiveRecord::Base
  URL_REGEXP = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  IMAGE_TYPES = %w(image/jpg image/jpeg image/pjpeg image/gif image/png image/x-png)

  # associations
  belongs_to :user

  # plugins
  has_attached_file :slide_preview,
    :styles => { :medium => "267x345>", :thumb => "116x150>" },
    :default_url => "/images/slide_:style.jpg"

  # scopes
  default_scope :order => 'start_on DESC'
  named_scope :next, lambda {|date| {:conditions=>["start_on >= ?",date]} }
  named_scope :past, lambda {|date| {:conditions=>["start_on < ?",date]} }

  # validations
  validates_presence_of :name, :description
  validates_attachment_content_type :slide_preview, :content_type => IMAGE_TYPES
  validates_attachment_size :slide_preview, :less_than => 5.megabytes

  with_options :allow_blank => true do |m|
    m.validates_length_of :name, :in => 1..255
    m.validates_uniqueness_of :name, :scope => :user_id, :case_sensitive => false
    m.validates_format_of :slides, :video, :code, :with => URL_REGEXP
  end

  def to_s
    name
  end
end

