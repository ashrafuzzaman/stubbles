require 'spec_helper'

describe "story_types/new" do
  before(:each) do
    assign(:story_type, stub_model(StoryType,
      :project => nil,
      :title => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new story_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", story_types_path, "post" do
      assert_select "input#story_type_project[name=?]", "story_type[project]"
      assert_select "input#story_type_title[name=?]", "story_type[title]"
      assert_select "textarea#story_type_description[name=?]", "story_type[description]"
    end
  end
end
