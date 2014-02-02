require 'spec_helper'

describe Story do
  describe '#propagate_values_to_story' do
    context 'with new task' do
      before do
        @story = FactoryGirl.create(:story, milestone: FactoryGirl.create(:milestone), story_type: StoryType.where(title: 'Feature').first)
        #FactoryGirl.create(:task, story: story, hours_estimated: 2, hours_spent: 2, percent_completed: 100)
      end

      it 'should propagate to story and mile stone' do
        ap @story.story_type.workflow_statuses.all
        expect(@story.workflow_status.title).to eq 'Open'
      end
    end
  end
end
