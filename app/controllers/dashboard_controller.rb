class DashboardController < ApplicationController
  before_filter :authenticate_user!
  respond_to :js, :json, :html, :xml

  def index
    @stories = filtered_stories
    @project.memberships.of(current_user).first.update_column(:last_accessed_at, Time.zone.now)
    @resources = @milestone.try(:resources) || []
    respond_with(@stories)
  end

  private
  def filtered_stories
    @project = Project.find(params[:project_id])
    @milestone = fetch_milestone(@project)
    stories = @milestone.try(:stories) || @project.stories.backlog
    stories = stories.involved_with(params[:involved_with]) if params[:involved_with].to_i > 0
    stories
  end

  def fetch_milestone(project)
    milestone = Milestone.cached_find params[:milestone_id] rescue nil
    milestone || (params.has_key?(:milestone_id) ? nil : project.current_sprint)
  end
end