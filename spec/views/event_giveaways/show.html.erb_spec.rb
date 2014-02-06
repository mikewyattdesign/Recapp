require 'spec_helper'

describe "event_giveaways/show" do
  before(:each) do
    @event_giveaway = assign(:event_giveaway, stub_model(EventGiveaway))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
