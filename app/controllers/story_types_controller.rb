class StoryTypesController < InheritedResources::Base
  before_filter :authenticate_user!
  belongs_to :project
  respond_to :html, :xml, :json, :js
  actions :all, :except => [:show]
end
