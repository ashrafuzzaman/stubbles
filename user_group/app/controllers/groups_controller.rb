class GroupsController < InheritedResources::Base
  belongs_to :project
  actions :all, :except => [:show]
end