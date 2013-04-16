require "spec_helper"

describe ExtensionsController do
  describe "routing" do

    it "routes to #index" do
      get("/extensions").should route_to("extensions#index")
    end

    it "routes to #new" do
      get("/extensions/new").should route_to("extensions#new")
    end

    it "routes to #show" do
      get("/extensions/1").should route_to("extensions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/extensions/1/edit").should route_to("extensions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/extensions").should route_to("extensions#create")
    end

    it "routes to #update" do
      put("/extensions/1").should route_to("extensions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/extensions/1").should route_to("extensions#destroy", :id => "1")
    end

    it "routes to #updates" do
      get("/extensions/updates.xml").should route_to("extensions#updates", :format => :xml)
    end

    it "routes to #crx" do
      get("/extensions/1/crx").should route_to("extensions#crx", :id => "1")
    end
  end
end
