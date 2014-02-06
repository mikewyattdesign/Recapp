require 'spec_helper'

describe "event_giveaways/edit" do
  before(:each) do
    @event_giveaway = assign(:event_giveaway, stub_model(EventGiveaway))
  end

  it "renders the edit event_giveaway form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", event_giveaway_path(@event_giveaway), "post" do
    end
  end
end
