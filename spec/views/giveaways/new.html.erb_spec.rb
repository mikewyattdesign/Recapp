require 'spec_helper'

describe "giveaways/new" do
  before(:each) do
    assign(:giveaway, stub_model(Giveaway).as_new_record)
  end

  it "renders new giveaway form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", giveaways_path, "post" do
    end
  end
end
