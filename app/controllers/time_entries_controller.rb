class TimeEntriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_project

  def weekly_time_entry
    @week = Week.new params[:week]
    @stories = @project.stories.yet_to_be_accepted.assigned_to_task_for(current_user)
  end

  def update_time_entry
    task = Task.find(params[:'task_id'])
    @time_entry = task.enter_time(current_user, params[:date], params[:hours_spent], params[:percent_completed])
  end

  private

  def load_project
    @project ||= current_user.projects.find(params[:project_id])
  end

  def fetch_milestone(project)
    milestone = Milestone.find params[:milestone_id] rescue nil
    milestone || (params.has_key?(:milestone_id) ? nil : project.current_sprint)
  end
end