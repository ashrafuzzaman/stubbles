require 'spec_helper'

describe "workflow_transitions/new" do
  before(:each) do
    assign(:workflow_transition, stub_model(WorkflowTransition,
      :event => "MyString",
      :from_status => nil,
      :to_status => nil
    ).as_new_record)
  end

  it "renders new workflow_transition form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", workflow_transitions_path, "post" do
      assert_select "input#workflow_transition_event[name=?]", "workflow_transition[event]"
      assert_select "input#workflow_transition_from_status[name=?]", "workflow_transition[from_status]"
      assert_select "input#workflow_transition_to_status[name=?]", "workflow_transition[to_status]"
    end
  end
end
