require 'spec_helper'

describe 'Audit' do
  context 'with new task' do
    before do
      FactoryGirl.create(:task, hours_estimated: 2, hours_spent: 2, percent_completed: 100)
    end

    it 'should propagate to story and mile stone' do

    end
  end
end