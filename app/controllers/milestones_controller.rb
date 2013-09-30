class MilestonesController < ApplicationController
  before_filter :load_project
  before_filter :load_form_dependencies, only: [:new, :edit, :create, :update]
  before_filter :authenticate_user!

  def index
    @milestones = @project.milestones

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @milestones }
    end
  end

  def show
    @milestone = @project.milestones.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @milestone }
    end
  end

  def new
    @milestone = @project.milestones.new
    @milestone.milestone_resources.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @milestone }
    end
  end

  def edit
    @milestone = @project.milestones.find(params[:id])
  end

  def create
    @milestone = @project.milestones.new(params[:milestone])

    respond_to do |format|
      if @milestone.save
        format.html { redirect_to [@project, @milestone], notice: '@project.milestones was successfully created.' }
        format.json { render json: @milestone, status: :created, location: @milestone }
      else
        format.html { render action: "new" }
        format.json { render json: @milestone.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @milestone = @project.milestones.find(params[:id])

    respond_to do |format|
      if @milestone.update_attributes(params[:milestone])
        format.html { redirect_to [@project, @milestone], notice: '@project.milestones was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @milestone.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @milestone = @project.milestones.find(params[:id])
    @milestone.destroy

    respond_to do |format|
      format.html { redirect_to milestones_url }
      format.json { head :no_content }
    end
  end

  def move_stories
    @stories = @project.move_stories_to_milestone(params[:milestone_id], params[:story_ids])
    respond_to do |format|
      format.js
    end
  end

  private

  def load_project
    @project = Project.find(params[:project_id])
  end

  def load_form_dependencies
    @long_milestones = @project.milestones.long
    @available_resources = @project.collaborators
  end
end
