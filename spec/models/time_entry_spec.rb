require 'spec_helper'

describe TimeEntry do
  describe '#cache_time_spent_in_trackable' do
    context 'enter time in task' do
      before do
        @story = FactoryGirl.create(:story)
        @task1 = FactoryGirl.create(:task, story: @story, hours_estimated: 10)
        @task2 = FactoryGirl.create(:task, story: @story, hours_estimated: 20)
      end

      it 'should propagate to story and mile stone' do
        user = FactoryGirl.create(:user)
        date = Date.current
        time_entry1 = @task1.enter_time(user, 1.day.ago.to_date, 5, 50)
        time_entry2 = @task1.enter_time(user, date, 5, 100)
        @task2.enter_time(user, date, 10, 50)


        expect(time_entry1.percent_completed_on_date).to eq 50
        expect(time_entry2.percent_completed_on_date).to eq 50

        @story = @story.reload
        expect(@story.hours_spent).to eq 20
        expect(@story.percent_completed).to eq 67
      end
    end
  end
end
