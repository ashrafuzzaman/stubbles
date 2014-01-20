require 'spec_helper'

describe "workflow_statuses/index" do
  before(:each) do
    assign(:workflow_statuses, [
      stub_model(WorkflowStatus,
        :title => "Title",
        :description => "Description",
        :statusable => nil
      ),
      stub_model(WorkflowStatus,
        :title => "Title",
        :description => "Description",
        :statusable => nil
      )
    ])
  end

  it "renders a list of workflow_statuses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
