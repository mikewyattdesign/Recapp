require 'rails_helper'

describe Comment do
    it 'is invalid without content' do
        expect do
            Comment.create!(content: nil)
        end.to raise_error(ActiveRecord::RecordInvalid, /content can't be blank/i)
    end
    it 'is valid with content' do 
        expect(Comment.new(content: "I'm a valid comment")).to be_valid
    end
    it 'can be event favorited' do
        expect(build(:comment)).to respond_to(:event_favorite)
    end
    it 'can be program favorited' do
        expect(build(:comment)).to respond_to(:program_favorite)
    end
    it 'can be brand favorited' do
        expect(build(:comment)).to respond_to(:brand_favorite)
    end
    it 'can belong to an event' do
    end
    it 'can be a testimonial' do
        expect(build(:comment)).to respond_to(:is_testimonial)
    end
    it 'can have a comment type' do
        expect(build(:comment)).to respond_to(:comment_type)
    end
end