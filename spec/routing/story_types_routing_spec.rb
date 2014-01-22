require "spec_helper"

describe StoryTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/story_types").should route_to("story_types#index")
    end

    it "routes to #new" do
      get("/story_types/new").should route_to("story_types#new")
    end

    it "routes to #show" do
      get("/story_types/1").should route_to("story_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/story_types/1/edit").should route_to("story_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/story_types").should route_to("story_types#create")
    end

    it "routes to #update" do
      put("/story_types/1").should route_to("story_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/story_types/1").should route_to("story_types#destroy", :id => "1")
    end

  end
end
