require 'spec_helper'

describe "story_types/index" do
  before(:each) do
    assign(:story_types, [
      stub_model(StoryType,
        :project => nil,
        :title => "Title",
        :description => "MyText"
      ),
      stub_model(StoryType,
        :project => nil,
        :title => "Title",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of story_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
