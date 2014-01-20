require 'spec_helper'

describe "workflow_statuses/new" do
  before(:each) do
    assign(:workflow_status, stub_model(WorkflowStatus,
      :title => "MyString",
      :description => "MyString",
      :statusable => nil
    ).as_new_record)
  end

  it "renders new workflow_status form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", workflow_statuses_path, "post" do
      assert_select "input#workflow_status_title[name=?]", "workflow_status[title]"
      assert_select "input#workflow_status_description[name=?]", "workflow_status[description]"
      assert_select "input#workflow_status_statusable[name=?]", "workflow_status[statusable]"
    end
  end
end
