class WorkflowStatusesController < InheritedResources::Base
  before_filter :authenticate_user!
  belongs_to :story_type, polymorphic: true
  actions :all, :except => [:show]

  respond_to :html, :xml, :json, :js

  def index
    @workflow_transitions = parent.workflow_transitions.includes [:from_status, :to_status]
    index!
  end

  def update
    update! do |success, failure|
      success.html { redirect_to [@story_type, WorkflowStatus] }
    end
  end
end