require 'spec_helper'

describe Task do
  describe '#propagate_values_to_story' do
    context 'with new task' do
      let(:story) { FactoryGirl.create(:story, milestone: FactoryGirl.create(:milestone)) }

      before do
        FactoryGirl.create(:task, story: story, hours_estimated: 2, hours_spent: 2, percent_completed: 100)
      end

      it 'should propagate to story and mile stone' do
        expect(story.hours_spent).to eq 2
        expect(story.hours_estimated).to eq 2
        expect(story.percent_completed).to eq 100

        milestone = story.milestone
        expect(milestone.hours_spent).to eq 2
        expect(milestone.hours_estimated).to eq 2
        expect(milestone.percent_completed).to eq 100
      end
    end

    context 'with new task to existing story' do
      let(:story) { FactoryGirl.create(:story, milestone: FactoryGirl.create(:milestone)) }

      before do
        FactoryGirl.create(:task, story: story, hours_estimated: 10, hours_spent: 2, percent_completed: 100)
        FactoryGirl.create(:task, story: story, hours_estimated: 20, hours_spent: 4, percent_completed: 50)
      end

      it 'should propagate to story and mile stone' do
        expect(story.hours_spent).to eq 6
        expect(story.hours_estimated).to eq 30
        expect(story.percent_completed).to eq 66

        milestone = story.milestone.reload
        expect(milestone.hours_spent).to eq 6
        expect(milestone.hours_estimated).to eq 30
        expect(milestone.percent_completed).to eq 66
      end
    end
  end
end
