require 'rails_helper'

describe Photo do
    it 'responds to tags' do
        expect(Photo.new).to respond_to(:tags)
    end

    it 'responds to event' do
        expect(Photo.new).to respond_to(:event)
    end

    xit 'should be invalid without an image'
end
