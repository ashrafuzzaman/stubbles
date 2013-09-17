require 'spec_helper'

describe "milestones/show" do
  before(:each) do
    @milestone = assign(:milestone, stub_model(Milestone,
      :title => "Title",
      :description => "MyText",
      :duration => 1,
      :type => "Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/Type/)
  end
end
