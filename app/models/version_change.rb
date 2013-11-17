class VersionChange < ActiveRecord::Base
  attr_accessible :version_id, :field, :now, :was

  belongs_to :version
end