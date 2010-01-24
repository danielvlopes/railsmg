require 'spec_helper'

describe HomeHelper do
  it 'link_to_take should return a Google Maps link' do
    helper.link_to_take.should have_tag 'a[href^=http://maps.google.com/maps]', 'veja o mapa'
  end
end
