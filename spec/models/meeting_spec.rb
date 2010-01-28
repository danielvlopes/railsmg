require 'spec_helper'

describe Meeting do
  # database
  should_have_columns :name, :video, :code, :slides, :type => :string
  should_have_column :description, :type => :text
  should_have_column :start_on, :type => :date

  # asssociations
  should_belong_to :user
 
  # plugins
  should_have_attached_file :slide_preview, :styles => { :medium => "267x345>", :thumb => "116x150>" }

  # scopes
  should_have_default_scope :order => 'start_on DESC'
  should_have_scope :next, :with => Date.today, :conditions=>["start_on >= ?",Date.today]
  should_have_scope :past, :with => Date.today, :conditions=>["start_on < ?",Date.today]  

  # validations
  should_validate_presence_of :name, :description

  with_options :allow_blank => true do |m|
    m.should_validate_length_of :name, :in => 1..255
    # TODO: remarkable fix: m.should_validate_uniqueness_of :name, :scope => :user_id, :case_sensitive => false
  end

  %w(slides video code).each do |attribute|
    should_allow_values_for attribute, "http://slideshare.net/slide1", "http://github.com/danielvlopes"
    should_not_allow_values_for attribute, "slideshare.net", "http://github/danielvlopes"
  end

  it 'to_s should return name' do
    subject.name = 'Nome da Palestra'
    subject.to_s.should eql 'Nome da Palestra'
  end
end
