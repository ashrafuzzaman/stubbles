require 'spec_helper'

describe "story_types/show" do
  before(:each) do
    @story_type = assign(:story_type, stub_model(StoryType,
      :project => nil,
      :title => "Title",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
  end
end
