require 'spec_helper'

describe "workflow_statuses/show" do
  before(:each) do
    @workflow_status = assign(:workflow_status, stub_model(WorkflowStatus,
      :title => "Title",
      :description => "Description",
      :statusable => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Description/)
    rendered.should match(//)
  end
end
