require 'spec_helper'

describe Video do
  it "responds to event" do
  	expect(Video.new).to respond_to(:event)
  end
  it "responds to media" do
  	expect(Video.new).to respond_to(:media)
  end
end
