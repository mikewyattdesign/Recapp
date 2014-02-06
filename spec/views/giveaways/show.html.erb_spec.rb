require 'spec_helper'

describe "giveaways/show" do
  before(:each) do
    @giveaway = assign(:giveaway, stub_model(Giveaway))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
