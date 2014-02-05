require 'spec_helper'

describe "brands/edit" do
  before(:each) do
    @brand = assign(:brand, stub_model(Brand))
  end

  it "renders the edit brand form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", brand_path(@brand), "post" do
    end
  end
end
