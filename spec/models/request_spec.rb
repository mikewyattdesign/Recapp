require 'rails_helper'

describe Request do
  # subject { create :request}

  xit { should respond_to :user}

  xit 'is invalid without a user' do
    expect(build(:request, user: nil)).to be_invalid
  end

  xit 'is invalid without a requestable type' do
  
  end
  
  xit 'is invalid without a requestable id' do 
  
  end
  
  xit 'can be tied to a brand' do
  
  end
  
  xit 'can be tied to a program' do
  
  end
  
  xit 'can be tied to an event' do
  
  end
  
  xit 'can be tied to a photo' do 
  
  end
  
  xit 'can be tied to a user' do
  
  end
  
  xit 'can be tied to a document' do
  
  end
  
  xit 'can be tied to a giveaway' do 
  
  end
  
  xit 'can be tied to a link' do
  
  end
  
  xit 'can be tied to a video' do 
  
  end

end
