class StoryCalendarController < ApplicationController
  before_filter :load_project, :authenticate_user!
	
  def index
    @users = @project.collaborators
  end

  def story_feed
    @stories = @project.stories
    user_id = params[:user_id].to_i
    @stories = @stories.assigned_to_task_for(User.find(user_id)) if user_id > 0
    render :json => @stories.map { |story| 
      { :id => story.id,
        :title => story.title,
        :start => story.start_at || Date.today,
        :end => story.complete_at || 
                (Date.today + (story.total_hours_estimated / Project::HOURS_PER_DAY) ) }
    }
  end

  def update_start_at
    @story = @project.stories.find(params[:id])
    start_at = time_after_delta(@story.start_at)
    complete_at = time_after_delta(@story.complete_at)
    if @story.update_attributes({:start_at => start_at, 
                                  :complete_at => complete_at})
      flash[:notice] = "Story scheduled on #{start_at}"
    else
      flash[:error] = @story.errors
    end
  end

  def update_complete_at
    @story = @project.stories.find(params[:id])
    complete_at = time_after_delta(@story.complete_at)
    if @story.update_attributes(:complete_at => complete_at)
      flash[:notice] = "Story estimated complete on #{complete_at}"
    else
      flash[:error] = @story.errors
    end
  end

	private

  def time_after_delta(time)
    time = (time || DateTime.now) + params[:dayDelta].to_i
    time.advance(:minutes => params[:minuteDelta].to_i)
  end

  def load_project
    @project = Project.find(params[:project_id])
  end
end