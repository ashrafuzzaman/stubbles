require 'spec_helper'

describe "workflow_transitions/show" do
  before(:each) do
    @workflow_transition = assign(:workflow_transition, stub_model(WorkflowTransition,
      :event => "Event",
      :from_status => nil,
      :to_status => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Event/)
    rendered.should match(//)
    rendered.should match(//)
  end
end
