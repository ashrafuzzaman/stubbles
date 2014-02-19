class MilestonesController < InheritedResources::Base
  belongs_to :project
  respond_to :html, :xml, :json, :js
  actions :all, :except => [:show]

  before_filter :load_project, only: [:move_stories, :copy_stories]
  before_filter :resource, only: [:send_report, :burn_down, :clone]
  before_filter :load_form_dependencies, only: [:new, :edit, :create, :update, :clone]
  before_filter :authenticate_user!

  def new
    new!
    @milestone.milestone_resources.build
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

  def send_report
    ReportMailer.sprint_report(params[:email], @milestone).deliver
    flash[:notice] = "Report send"
    respond_to do |format|
      format.js
    end
  end

  private

  def load_form_dependencies
    @long_milestones = @project.milestones.long
    @available_resources = @project.collaborators
  end

  def load_project
    @project = Project.find(params[:project_id])
  end
end
