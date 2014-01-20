require 'spec_helper'

describe "WorkflowStatuses" do
  describe "GET /workflow_statuses" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get workflow_statuses_path
      response.status.should be(200)
    end
  end
end
