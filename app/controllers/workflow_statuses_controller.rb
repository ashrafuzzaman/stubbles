class WorkflowStatusesController < InheritedResources::Base
  before_filter :authenticate_user!
  belongs_to :story_type, polymorphic: true
  respond_to :html, :xml, :json, :js
end