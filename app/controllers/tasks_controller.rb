class TasksController < InheritedResources::Base
  before_filter :authenticate_user!
  belongs_to :story
  respond_to :html, :xml, :json, :js

  def update_status
    resource.update_attributes workflow_status_id: params[:workflow_status_id]
  end
end