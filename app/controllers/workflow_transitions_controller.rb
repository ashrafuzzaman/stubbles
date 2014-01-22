class WorkflowTransitionsController < InheritedResources::Base
  before_filter :authenticate_user!
  belongs_to :story_type
  respond_to :html, :xml, :json, :js
end