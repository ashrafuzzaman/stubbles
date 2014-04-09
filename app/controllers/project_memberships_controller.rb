class ProjectMembershipsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_project
  before_filter :validate_access
  before_filter :find_user_to_add_as_member, :only => :create

  def index
    @project_memberships = @project.memberships
    @project_membership = ProjectMembership.new

    respond_to do |format|
      format.html
      format.json { render :json => @project_memberships }
    end
  end

  def create
    @project = current_user.projects.find(params[:project_id])
    @project_membership = @project.memberships.new(:user_id => @user.try(:id))

    respond_to do |format|
      if @project_membership.save
        flash[:notice] = 'User is successfully added.'
        format.js
      else
        flash[:error] = @project_membership.errors.full_messages
        format.js
      end
    end
  end

  def destroy
    @project_membership = @project.memberships.unscoped.find(params[:id])
    @project_membership.destroy

    respond_to do |format|
      format.html { redirect_to project_project_memberships_url(@project) }
      format.json { head :ok }
      format.js
    end
  end

  def activate
    activation(:activate)
  end

  def deactivate
    activation(:deactivate)
  end

  def activation(method_to_call)
    @project = current_user.projects.find(params[:project_id])
    @project_membership = @project.memberships.unscoped.find(params[:id])

    respond_to do |format|
      if @project_membership.send(method_to_call)
        format.html { redirect_to project_project_memberships_url(@project) }
        format.json { render :json => @project_membership, :status => :created, :location => @project }
        format.js
      else
        format.html { render :action => "index" }
        format.json { render :json => @project_membership.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  private

  def load_project
    @project = current_user.projects.find(params[:project_id])
  end

  def validate_access
    unauthorized_access if !@project.permitted_to_manage_members_by?(current_user)
  end

  def find_user_to_add_as_member
    @user = User.find_by_email(params[:email])
    if @user.nil?
      flash[:error] = 'User not found'
      return false
    else
      return true
    end
  end

end