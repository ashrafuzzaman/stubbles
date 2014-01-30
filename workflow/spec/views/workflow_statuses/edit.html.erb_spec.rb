require 'spec_helper'

describe "workflow_statuses/edit" do
  before(:each) do
    @workflow_status = assign(:workflow_status, stub_model(WorkflowStatus,
      :title => "MyString",
      :description => "MyString",
      :statusable => nil
    ))
  end

  it "renders the edit workflow_status form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", workflow_status_path(@workflow_status), "post" do
      assert_select "input#workflow_status_title[name=?]", "workflow_status[title]"
      assert_select "input#workflow_status_description[name=?]", "workflow_status[description]"
      assert_select "input#workflow_status_statusable[name=?]", "workflow_status[statusable]"
    end
  end
end
