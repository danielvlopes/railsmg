require 'spec_helper'

describe MeetingsHelper do

  describe "when ask for meeting_attachments" do
    before(:each) do
      @meeting = Meeting.new
      @url = "http://test.com/example"
    end
    
    it 'should print code link if present' do
      @meeting.stub!(:code).and_return(@url)
      output = helper.meeting_attachments(@meeting)
      output.should have_selector("a", :href=>@url, :content=>"CODE")
    end
    
    it 'should print video link if present' do
      @meeting.stub!(:video).and_return(@url)
      output = helper.meeting_attachments(@meeting)
      output.should have_selector("a", :href=>@url, :content=>"VÍDEO")
    end

    it 'should print slides link if present' do
      @meeting.stub!(:slides).and_return(@url)
      output = helper.meeting_attachments(@meeting)
      output.should have_selector("a", :href=>@url, :content=>"SLIDES")
    end
            
    it 'should print unavailable if code,video and slides are empty' do
      [:slides, :video, :code].each { |m| @meeting.stub!(m).and_return(nil) }
      output = helper.meeting_attachments(@meeting)
      output.should == "Não disponível"
    end
  end

end
