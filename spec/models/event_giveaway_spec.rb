require 'rails_helper'

describe EventGiveaway do
    before { 
        @event = create(:event)
        @giveaway = Giveaway.create(name: 'Generic Giveaway')
        @eventgiveaway = EventGiveaway.create(event_id: @event.id, giveaway_id: @giveaway.id)
    }
    it 'is invalid without an event' do  
        expect do
            EventGiveaway.create!(event_id: nil, giveaway_id: 1)
        end.to raise_error(ActiveRecord::RecordInvalid, /Event can't be blank/i)
    end
    it 'is invalid without a giveaway' do
        expect do
            EventGiveaway.create!(giveaway_id: nil, event_id: 1)
        end.to raise_error(ActiveRecord::RecordInvalid, /Giveaway can't be blank/i)
    end
    it 'belongs to an event' do
        expect(@eventgiveaway.event).to eq @event
    end
    it 'belongs to a giveaway' do
        expect(@eventgiveaway.giveaway).to eq @giveaway
    end
    it 'can be an event favorite' do 
        expect(@eventgiveaway).to respond_to(:event_favorite)
    end
end
