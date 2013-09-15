class ProjectReportsController < ApplicationController
  before_filter :load_project, :authenticate_user!
	
  def sprint_burndown
    #time_entries = @project.stories.current.tasks.time_entries

    #@chart_data = time_entries.map { |time_entry|
    #  { :id => time_entry.id,
    #    :title => time_entry.hours_spent }
    #}
  end

	private

  def load_project
    @project = Project.find(params[:project_id])
  end
end