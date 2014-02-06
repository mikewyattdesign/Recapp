require 'spec_helper'

describe "event_giveaways/index" do
  before(:each) do
    assign(:event_giveaways, [
      stub_model(EventGiveaway),
      stub_model(EventGiveaway)
    ])
  end

  it "renders a list of event_giveaways" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
