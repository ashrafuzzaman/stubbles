class StoryTypesController < InheritedResources::Base
  before_filter :authenticate_user!
  belongs_to :project
  respond_to :html, :xml, :json, :js
end
