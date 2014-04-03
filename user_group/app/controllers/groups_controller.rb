class GroupsController < InheritedResources::Base
  belongs_to :project
  actions :all, :except => [:show]
  custom_actions :collection => :assign

  def assign
    Group.assign!(Project.find(params[:project_id]), User.find(params[:user_id]), params[:group_ids])
    flash[:notice] = "Operation completed"
  end
end