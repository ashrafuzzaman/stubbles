class Version < ActiveRecord::Base
  attr_accessible :event, :done_by_id, :object

  belongs_to :trackable, polymorphic: true
  has_many :version_changes
end