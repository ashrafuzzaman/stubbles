require 'spec_helper'

describe "groups/new" do
  before(:each) do
    assign(:group, stub_model(Group,
      :title => "MyString",
      :description => "MyText",
      :project_id => 1,
      :total_members => 1
    ).as_new_record)
  end

  it "renders new group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", groups_path, "post" do
      assert_select "input#group_title[name=?]", "group[title]"
      assert_select "textarea#group_description[name=?]", "group[description]"
      assert_select "input#group_project_id[name=?]", "group[project_id]"
      assert_select "input#group_total_members[name=?]", "group[total_members]"
    end
  end
end
