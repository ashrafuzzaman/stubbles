class MilestonesController < ApplicationController
  before_filter :load_project
  before_filter :load_form_dependencies, only: [:new, :edit, :create, :update, :clone]
  before_filter :authenticate_user!, except: [:burn_down]

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

  def clone
    @milestone_to_clone = @project.milestones.find(params[:id])
    @milestone = @milestone_to_clone.dup
    @milestone.milestone_resources << @milestone_to_clone.milestone_resources.collect(&:dup)

    @milestone.title = @milestone.title.gsub(/(\d+)/) do |n|
      n.to_i + 1
    end
    @milestone.end_on       = Date.current + (@milestone_to_clone.end_on - @milestone_to_clone.start_on).to_i.days
    @milestone.delivered_on = @milestone.end_on
    @milestone.start_on     = Date.current
    ap @milestone
    render :new
  end

  def edit
    @milestone = @project.milestones.find(params[:id])
  end

  def create
    @milestone = @project.milestones.new(params[:milestone])

    respond_to do |format|
      if @milestone.save
        format.html { redirect_to project_milestones_path(@project), notice: 'Milestone was successfully created.' }
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
        format.html { redirect_to project_milestones_path(@project), notice: 'Milestone was successfully updated.' }
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
    @from_milestone = Milestone.find(params[:from_milestone_id]) rescue nil
    @stories = @project.move_stories_to_milestone(params[:milestone_id], params[:story_ids])
    respond_to do |format|
      format.js
    end
  end

  def copy_stories
    @from_milestone = Milestone.find(params[:from_milestone_id]) rescue nil
    @stories = @project.copy_stories_to_milestone(params[:milestone_id], params[:story_ids])
    respond_to do |format|
      format.js
    end
  end

  def burn_down
    milestone = @project.milestones.find(params[:id]) rescue nil
    chart = milestone.try(:burn_down_chart)
    send_data(chart.try(:to_blob), :filename => "burn_down.png", :type => 'image/png', :disposition=> 'inline')
  end

  def send_report
    @milestone = @project.milestones.find(params[:id])
    ReportMailer.sprint_report(params[:email], @milestone).deliver
    flash[:notice] = "Report send"
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
