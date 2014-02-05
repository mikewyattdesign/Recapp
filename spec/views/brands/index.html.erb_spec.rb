require 'spec_helper'

describe "brands/index" do
  before(:each) do
    assign(:brands, [
      stub_model(Brand),
      stub_model(Brand)
    ])
  end

  it "renders a list of brands" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
