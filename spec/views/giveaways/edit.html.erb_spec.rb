require 'spec_helper'

describe "giveaways/edit" do
  before(:each) do
    @giveaway = assign(:giveaway, stub_model(Giveaway))
  end

  it "renders the edit giveaway form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", giveaway_path(@giveaway), "post" do
    end
  end
end
