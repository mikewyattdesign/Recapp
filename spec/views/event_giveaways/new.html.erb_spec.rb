require 'spec_helper'

describe "event_giveaways/new" do
  before(:each) do
    assign(:event_giveaway, stub_model(EventGiveaway).as_new_record)
  end

  it "renders new event_giveaway form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", event_giveaways_path, "post" do
    end
  end
end
