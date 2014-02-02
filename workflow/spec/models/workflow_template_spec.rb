require 'spec_helper'

describe WorkflowTemplate do
  describe 'create_workflow!' do
    context 'with default template' do
      before { @project = FactoryGirl.create(:project) }
      it 'creates default workflow' do
        template = WorkflowTemplate.new @project
        template.create_workflow!
        expect(@project.story_types.count).to eq 3

        feature = @project.story_types.where(title: 'Feature').first
        expect(feature.default_color).to eq 'default'
        expect(feature.workflow_statuses.count).to eq 7

        expect(feature.workflow_transitions.where(event: 'Done').first.button_color).to eq 'green'
      end
    end
  end
end
