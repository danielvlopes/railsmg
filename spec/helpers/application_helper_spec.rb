require 'spec_helper'

describe ApplicationHelper do
  describe "when ask for gravatar_image_tag " do
    it 'should return a gravatar image' do
      helper.gravatar_image_tag('john@doe.com').should have_tag 'img[src^=http://www.gravatar.com/avatar/][alt=Gravatar]'
    end
  end

  describe "when ask for google_analytics" do
    it 'should render analytics code when in production' do
      Rails.stub(:env).and_return("production")
      helper.should_receive(:render).with(:partial => "shared/analytics")
      helper.google_analytics
    end
  end

end
