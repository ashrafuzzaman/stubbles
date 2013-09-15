class TasksController < ApplicationController
  respond_to :js, :json, :html, :xml
  before_filter :load_story, :authenticate_user!

  def index
    @tasks = @story.tasks
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = @story.tasks.find(params[:id])
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = @story.tasks.new
  end

  # GET /tasks/1/edit
  def edit
    @task = @story.tasks.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @story.tasks.new(params[:task])
    if @task.save
      flash[:notice] = "Task created"
    else
      flash[:error] = @task.errors
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = @story.tasks.find(params[:id])
    if @task.update_attributes(params[:task])
      flash[:notice] = "Task created"
    else
      flash[:error] = @task.errors
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = @story.tasks.find(params[:id])
    @task.destroy
    flash[:notice] = "Task deleted"
  end

  def update_status
    @task = @story.tasks.find(params[:id])
    @task.send("#{params[:event]}!")
  end

  private

  def load_story
    @story = Story.find(params[:story_id])
  end

end