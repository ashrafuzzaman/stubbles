require 'spec_helper'

describe Task do
  describe '#propagate_values_to_story' do
    context 'creating test' do
      before do
        @task = FactoryGirl.create(:task, hours_spent: 2)
      end
      subject{ @task.story.reload }
      its(:hours_spent) { should == 2 }
    end
  end
end
