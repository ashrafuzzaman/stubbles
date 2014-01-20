require "spec_helper"

describe WorkflowStatusesController do
  describe "routing" do

    it "routes to #index" do
      get("/workflow_statuses").should route_to("workflow_statuses#index")
    end

    it "routes to #new" do
      get("/workflow_statuses/new").should route_to("workflow_statuses#new")
    end

    it "routes to #show" do
      get("/workflow_statuses/1").should route_to("workflow_statuses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/workflow_statuses/1/edit").should route_to("workflow_statuses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/workflow_statuses").should route_to("workflow_statuses#create")
    end

    it "routes to #update" do
      put("/workflow_statuses/1").should route_to("workflow_statuses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/workflow_statuses/1").should route_to("workflow_statuses#destroy", :id => "1")
    end

  end
end
