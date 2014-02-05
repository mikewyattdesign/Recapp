require 'spec_helper'

describe "brands/show" do
  before(:each) do
    @brand = assign(:brand, stub_model(Brand))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
