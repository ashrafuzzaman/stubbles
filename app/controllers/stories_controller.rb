class StoriesController < ApplicationController
  respond_to :js, :json, :html, :xml
  before_filter :load_project, :authenticate_user!
  
  def index
    @stories = @project.stories
    respond_with(@stories)
  end

  def show
    @story = @project.stories.find(params[:id])
  end

  def new
    @story = @project.stories.new
  end

  def edit
    @story = @project.stories.find(params[:id])
  end

  def create
    @story = @project.stories.new(params[:story])
    if @story.save
      flash[:notice] = "Story created"
    else
      flash[:error] = @story.errors
    end
  end

  def update
    @story = @project.stories.find(params[:id])
    if @story.update_attributes(params[:story])
      flash[:notice] = "Story updated"
    else
      flash[:error] = @story.errors
    end
  end

  def update_status
    @story = @project.stories.find(params[:id])
    @story.send("#{params[:event]}!")
  end

  def update_scope_and_priority
    scope               = params[:scope]
    story_id            = params[:story_id].to_i
    shift_from_story_id = params[:shift_from_story_id].to_i
    Story.update_scope_and_priority(@project, scope, story_id, shift_from_story_id)
  end

  def destroy
    @story = @project.stories.find(params[:id])
    @story.destroy
    flash[:notice] = "Story deleted"
  end
  
  private

  def load_project
    @project = Project.find(params[:project_id])
  end
end
