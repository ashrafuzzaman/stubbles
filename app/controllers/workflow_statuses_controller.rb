class WorkflowStatusesController < InheritedResources::Base
  belongs_to :project
  respond_to :html, :xml, :json, :js
end