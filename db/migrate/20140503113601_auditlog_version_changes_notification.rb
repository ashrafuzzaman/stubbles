class AuditlogVersionChangesNotification < ActiveRecord::Migration
  def change
    create_table :auditlog_change_notifications do |t|
      t.references :model, :polymorphic => true
      t.references :version_change, :null => false
    end
  end
end