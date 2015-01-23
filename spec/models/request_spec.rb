require 'spec_helper'

describe Request do
  subject { create :request}

  it { should respond_to :user}

  it 'is invalid without a user' do
    expect(build(:request, user: nil)).to be_invalid
  end

  it 'is invalid without a requestable type' do
  
  end
  
  it 'is invalid without a requestable id' do 
  
  end
  
  it 'can be tied to a brand' do
  
  end
  
  it 'can be tied to a program' do
  
  end
  
  it 'can be tied to an event' do
  
  end
  
  it 'can be tied to a photo' do 
  
  end
  
  it 'can be tied to a user' do
  
  end
  
  it 'can be tied to a document' do
  
  end
  
  it 'can be tied to a giveaway' do 
  
  end
  
  it 'can be tied to a link' do
  
  end
  
  it 'can be tied to a video' do 
  
  end

end
