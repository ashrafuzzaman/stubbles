require 'spec_helper'

describe Task do
  describe '#propagate_percent_completed' do
    context 'with milestone assigned' do
      let(:milestone) { FactoryGirl.create(:milestone) }
      let(:story) { FactoryGirl.create(:story) }

      before do
        FactoryGirl.create(:task, story: story, hours_estimated: 10, hours_spent: 2, percent_completed: 100)
        FactoryGirl.create(:task, story: story, hours_estimated: 20, hours_spent: 4, percent_completed: 50)
        story.milestone = milestone
        story.save
      end

      it 'should propagate to story and mile stone' do
        milestone = story.milestone.reload
        expect(milestone.hours_spent).to eq 6
        expect(milestone.hours_estimated).to eq 30
        expect(milestone.percent_completed).to eq 67
      end
    end

    context 'with sprint de scoped' do
      let(:story) { FactoryGirl.create(:story, milestone: FactoryGirl.create(:milestone)) }

      before do
        FactoryGirl.create(:task, story: story, hours_estimated: 10, hours_spent: 2, percent_completed: 100)
        FactoryGirl.create(:task, story: story, hours_estimated: 20, hours_spent: 4, percent_completed: 50)
      end

      it 'should propagate to story and mile stone' do
        milestone = story.milestone
        story.milestone = nil
        story.save!
        milestone = milestone.reload

        expect(milestone.hours_spent).to eq 0
        expect(milestone.hours_estimated).to eq 0
        expect(milestone.percent_completed).to eq 0
      end
    end

    context 'switching from sprints' do
      let(:story) { FactoryGirl.create(:story, milestone: FactoryGirl.create(:milestone)) }

      before do
        FactoryGirl.create(:task, story: story, hours_estimated: 10, hours_spent: 2, percent_completed: 100)
        FactoryGirl.create(:task, story: story, hours_estimated: 20, hours_spent: 4, percent_completed: 50)
      end

      it 'should propagate to story and mile stone' do
        milestone = story.milestone
        story.milestone = FactoryGirl.create(:milestone)
        story.save!
        milestone = milestone.reload

        #old milestone
        expect(milestone.hours_spent).to eq 0
        expect(milestone.hours_estimated).to eq 0
        expect(milestone.percent_completed).to eq 0

        #new milestone
        milestone = story.milestone.reload
        expect(milestone.hours_spent).to eq 6
        expect(milestone.hours_estimated).to eq 30
        expect(milestone.percent_completed).to eq 67
      end
    end
  end
end
