require 'spec_helper'

describe "story_types/edit" do
  before(:each) do
    @story_type = assign(:story_type, stub_model(StoryType,
      :project => nil,
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit story_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", project_story_type_path(@story_type), "post" do
      assert_select "input#story_type_project[name=?]", "story_type[project]"
      assert_select "input#story_type_title[name=?]", "story_type[title]"
      assert_select "textarea#story_type_description[name=?]", "story_type[description]"
    end
  end
end
