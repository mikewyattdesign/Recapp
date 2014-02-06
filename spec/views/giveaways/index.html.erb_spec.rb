require 'spec_helper'

describe "giveaways/index" do
  before(:each) do
    assign(:giveaways, [
      stub_model(Giveaway),
      stub_model(Giveaway)
    ])
  end

  it "renders a list of giveaways" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
