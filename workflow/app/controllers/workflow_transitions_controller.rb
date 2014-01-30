class WorkflowTransitionsController < InheritedResources::Base
  before_filter :authenticate_user!
  belongs_to :story_type
  actions :all, :except => [:show]

  respond_to :html, :xml, :json, :js
end