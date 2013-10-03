class TimeEntriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_project

  def weekly_time_entry
    @week = Week.new params[:week]
    @user = params[:user_id].present? ? User.find(params[:user_id]) : current_user
    @stories = @project.stories.yet_to_be_accepted.assigned_to_task_for(@user)
    @users = @project.collaborators
  end

  def update_time_entry
    @time_entry = Task.find(params[:'task_id']).time_entries.spent_on(params[:date]).by(current_user).first_or_create
    @time_entry.hours_spent = params[:value]
    @time_entry.save
  end

  private

  def load_project
    @project = current_user.projects.find(params[:project_id])
  end

end