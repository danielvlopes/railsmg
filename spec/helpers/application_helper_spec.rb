require 'spec_helper'

describe ApplicationHelper do
  it 'gravatar_image_tag should return a gravatar image' do
    helper.gravatar_image_tag('john@doe.com').should have_tag 'img[src^=http://www.gravatar.com/avatar/][alt=Gravatar]'
  end
end
