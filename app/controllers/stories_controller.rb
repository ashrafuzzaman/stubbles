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
    @story = @project.stories.new(milestone_id: params[:milestone_id])
  end

  def edit
    @story = @project.stories.find(params[:id])
  end

  def create
    @story = @project.stories.new(params[:story])
    if @story.save
      flash[:notice] = "Story created"
    else
      flash[:error] = @story.errors.full_messages
    end
  end

  def update
    @story = @project.stories.find(params[:id])

    ap params[:story]
    respond_to do |format|
      if @story.update_attributes(params[:story])
        flash[:notice] = "Story updated"
        format.js
        format.json { head :no_content }
      else
        flash[:error] = @story.errors.full_messages
        format.js
        format.json { render json: @story.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update_status
    @story = @project.stories.find(params[:id])
    @story.send("#{params[:event]}!")
  end

  def update_scope_and_priority
    scope = params[:scope]
    story_id = params[:story_id].to_i
    shift_from_story_id = params[:shift_from_story_id].to_i
    Story.update_scope_and_priority(@project, scope, story_id, shift_from_story_id)
  end

  def destroy
    @story = @project.stories.find(params[:id])
    @story.destroy
    flash[:notice] = "Story deleted"
  end

  def upload_attachments
    @story = @project.stories.find(params[:id])

    respond_to do |format|
      if @story.attachments.create(file: params[:story][:file])
        format.js
      else
        format.js
      end
    end
  end

  private

  def load_project
    @project = Project.find(params[:project_id])
  end
end
