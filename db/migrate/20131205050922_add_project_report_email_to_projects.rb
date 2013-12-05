class AddProjectReportEmailToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :default_report_emails, :string
  end
end