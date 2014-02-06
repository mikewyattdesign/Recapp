require "spec_helper"

describe GiveawaysController do
  describe "routing" do

    it "routes to #index" do
      get("/giveaways").should route_to("giveaways#index")
    end

    it "routes to #new" do
      get("/giveaways/new").should route_to("giveaways#new")
    end

    it "routes to #show" do
      get("/giveaways/1").should route_to("giveaways#show", :id => "1")
    end

    it "routes to #edit" do
      get("/giveaways/1/edit").should route_to("giveaways#edit", :id => "1")
    end

    it "routes to #create" do
      post("/giveaways").should route_to("giveaways#create")
    end

    it "routes to #update" do
      put("/giveaways/1").should route_to("giveaways#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/giveaways/1").should route_to("giveaways#destroy", :id => "1")
    end

  end
end
