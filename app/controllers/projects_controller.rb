class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_project, :except => [:new, :index, :create]

  def index
    @projects = current_user.projects

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @projects }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @project }
    end
  end

  def new
    @project = current_user.projects.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @project }
    end
  end

  def edit
  end

  def create
    @project = current_user.projects.new({:creator => current_user}.merge(params[:project]))

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, :notice => 'Project was successfully created.' }
        format.json { render :json => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.json { render :json => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to projects_path, :notice => 'Project was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :ok }
    end
  end

  def time_entry
    @week = Week.new params[:week]
    @user = params[:user_id].present? ? User.find(params[:user_id]) : current_user
    @stories = @project.stories.yet_to_be_accepted.assigned_to_task_for(@user)
    @users = @project.collaborators
  end

  def update_time_entry
    @time_entry =  Task.find(params[:'resourceId']).time_entries.spent_on(params[:date]).by(current_user).first_or_create
    @time_entry.hours_spent = params[:value]
    @time_entry.save
  end

  private

  def load_project
    @project = current_user.projects.find(params[:id])
  end

end