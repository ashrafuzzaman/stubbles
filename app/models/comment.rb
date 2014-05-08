require 'auditlog/model_tracker'

class Comment < ActiveRecord::Base
  attr_accessible :text

  include CommentPermission
  include Auditlog::ModelTracker
  track only: [:text], notify: {commentable: [:text]}

  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  validates :text, :presence => true
  scope :order_by_recent, -> { order 'created_at ASC' }
  default_scope { order_by_recent }
end