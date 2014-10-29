require 'spec_helper'

describe Photo do
    it 'responds to tags' do
        expect(Photo.new).to respond_to(:tags)
    end
    xit 'should be invalid without an image'
end
