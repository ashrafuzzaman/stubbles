class WorkflowTransitionsController < InheritedResources::Base
  before_filter :authenticate_user!
  belongs_to :story_type
  actions :all, :except => [:show]

  respond_to :html, :xml, :json, :js

  def destroy
    super do |format|
      format.html { redirect_to [@story_type, :workflow_statuses] }
    end
  end

  def update
    super do |format|
      format.html { redirect_to [@story_type, :workflow_statuses] }
    end
  end

  def create
    super do |format|
      format.html { redirect_to [@story_type, :workflow_statuses] }
    end
  end
end