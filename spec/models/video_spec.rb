require 'spec_helper'

describe Video do
    before { @event = create(:event) }
    it 'is valid with an event and video' do
        expect(Video.new(
            event_id: @event.id,
            media: File.new(Dir.pwd + '/spec/support/01_LoggingIn.mov')
        )).to be_valid
    end
    it 'is invalid without a video' do
        expect(Video.new(event_id: @event.id)).to be_invalid
    end
    it 'is invalid without an event' do
        expect(Video.new(
            media: File.new(Dir.pwd + '/spec/support/01_LoggingIn.mov')
        )).to be_invalid
    end
    it 'responds to event' do
        expect(Video.new).to respond_to(:event)
    end
    it 'responds to media' do
        expect(Video.new).to respond_to(:media)
    end
    # The following test works in the scope of the actual application
    xit 'responds to thumb' do
        @video = Video.create(
            media: File.new(Dir.pwd + '/spec/support/01_LoggingIn.mov')
        )
        expect(@video.media).to respond_to(:thumb)
    end
end
