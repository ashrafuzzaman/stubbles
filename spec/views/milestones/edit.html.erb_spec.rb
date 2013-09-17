require 'spec_helper'

describe "milestones/edit" do
  before(:each) do
    @milestone = assign(:milestone, stub_model(Milestone,
      :title => "MyString",
      :description => "MyText",
      :duration => 1,
      :type => ""
    ))
  end

  it "renders the edit milestone form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", milestone_path(@milestone), "post" do
      assert_select "input#milestone_title[name=?]", "milestone[title]"
      assert_select "textarea#milestone_description[name=?]", "milestone[description]"
      assert_select "input#milestone_duration[name=?]", "milestone[duration]"
      assert_select "input#milestone_type[name=?]", "milestone[type]"
    end
  end
end
