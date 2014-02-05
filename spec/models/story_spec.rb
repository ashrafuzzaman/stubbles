require 'spec_helper'

describe Story do
  describe '#propagate_values_to_story' do
    context 'with no task' do
      before do
        project = FactoryGirl.create(:project)
        @story = FactoryGirl.create(:story, project: project, milestone: FactoryGirl.create(:milestone), story_type: StoryType.where(title: 'Feature').first)
      end
      subject { @story }
      its(:workflow_status) { should be nil }
    end

    context 'with 2 tasks one is open and other is qa approved' do
      before do
        project = FactoryGirl.create(:project)
        st = StoryType.where(title: 'Feature').first
        @story = FactoryGirl.create(:story, project: project, milestone: FactoryGirl.create(:milestone), story_type: st)
        FactoryGirl.create(:task, story: @story, hours_estimated: 2, workflow_status: WorkflowStatus.where(title: 'Open').first)
        FactoryGirl.create(:task, story: @story, hours_estimated: 2, workflow_status: WorkflowStatus.where(title: 'Qa approved').first)
      end

      subject { @story.reload }
      its(:workflow_status) { should eq WorkflowStatus.where(title: 'Open').first }
    end

    context 'with 2 tasks one is open and other is qa approved' do
      before do
        project = FactoryGirl.create(:project)
        st = StoryType.where(title: 'Feature').first
        @story = FactoryGirl.create(:story, project: project, milestone: FactoryGirl.create(:milestone), story_type: st)
        FactoryGirl.create(:task, story: @story, hours_estimated: 2, workflow_status: WorkflowStatus.where(title: 'Qa approved').first)
        FactoryGirl.create(:task, story: @story, hours_estimated: 2, workflow_status: WorkflowStatus.where(title: 'Done').first)
      end

      subject { @story.reload }
      its(:workflow_status) { should eq WorkflowStatus.where(title: 'Done').first }
    end
  end
end
