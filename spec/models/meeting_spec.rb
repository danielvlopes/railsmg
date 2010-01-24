require 'spec_helper'

describe Meeting do
  before do
    @meeting = Meeting.make
  end

  # Upload
  should_have_attached_file(:slide_preview, :styles => { :medium => "267x345>", :thumb => "116x150>" })  

  # Database
  should_have_column :name, :type => :string
  should_have_column :description, :type => :text

  # Scopes
  should_have_default_scope :order => 'start_on DESC'

  # Validations
  should_validate_presence_of :name, :description
  
  # FIXME: Find a way to be more DRY
  describe "when seting a url" do
    before :all do
      @good_urls = "http://slideshare.net/slide1", "http://github.com/danielvlopes"
      @bad_urls  = "slideshare.net", "http://github/danielvlopes"
    end
    
    it { should allow_values_for :slides, @good_urls }
    it { should_not allow_values_for :slides, @bad_urls }
    it { should allow_values_for :video, @good_urls }
    it { should_not allow_values_for :video, @bad_urls }
    it { should allow_values_for :code, @good_urls }
    it { should_not allow_values_for :code, @bad_urls }  
  end

  with_options :allow_blank => true do |m|
    m.should_validate_length_of :name, :in => 1..255
    m.should_validate_uniqueness_of :name, :scope => :user_id, :case_sensitive => false
  end

  it 'to_s should return name' do
    @meeting.name.should be_eql(@meeting.name)
  end
  
end