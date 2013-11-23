class MilestoneCalendarController < ApplicationController
  before_filter :load_project, :authenticate_user!

  def index
  end

  def feed
    @milestones = @project.milestones
    render :json => @milestones.map { |milestone|
      {:id => milestone.id,
       :title => milestone.title,
       :start => milestone.start_on,
       :end => milestone.end_on}
    }
  end

  private

  def load_project
    @project = Project.find(params[:project_id])
  end
end