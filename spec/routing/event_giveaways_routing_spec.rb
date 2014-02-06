require "spec_helper"

describe EventGiveawaysController do
  describe "routing" do

    it "routes to #index" do
      get("/event_giveaways").should route_to("event_giveaways#index")
    end

    it "routes to #new" do
      get("/event_giveaways/new").should route_to("event_giveaways#new")
    end

    it "routes to #show" do
      get("/event_giveaways/1").should route_to("event_giveaways#show", :id => "1")
    end

    it "routes to #edit" do
      get("/event_giveaways/1/edit").should route_to("event_giveaways#edit", :id => "1")
    end

    it "routes to #create" do
      post("/event_giveaways").should route_to("event_giveaways#create")
    end

    it "routes to #update" do
      put("/event_giveaways/1").should route_to("event_giveaways#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/event_giveaways/1").should route_to("event_giveaways#destroy", :id => "1")
    end

  end
end
