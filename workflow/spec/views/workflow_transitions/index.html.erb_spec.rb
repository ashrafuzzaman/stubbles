require 'spec_helper'

describe "workflow_transitions/index" do
  before(:each) do
    assign(:workflow_transitions, [
      stub_model(WorkflowTransition,
        :event => "Event",
        :from_status => nil,
        :to_status => nil
      ),
      stub_model(WorkflowTransition,
        :event => "Event",
        :from_status => nil,
        :to_status => nil
      )
    ])
  end

  it "renders a list of workflow_transitions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Event".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
