require "spec_helper"

describe WorkflowTransitionsController do
  describe "routing" do

    it "routes to #index" do
      get("/workflow_transitions").should route_to("workflow_transitions#index")
    end

    it "routes to #new" do
      get("/workflow_transitions/new").should route_to("workflow_transitions#new")
    end

    it "routes to #show" do
      get("/workflow_transitions/1").should route_to("workflow_transitions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/workflow_transitions/1/edit").should route_to("workflow_transitions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/workflow_transitions").should route_to("workflow_transitions#create")
    end

    it "routes to #update" do
      put("/workflow_transitions/1").should route_to("workflow_transitions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/workflow_transitions/1").should route_to("workflow_transitions#destroy", :id => "1")
    end

  end
end
