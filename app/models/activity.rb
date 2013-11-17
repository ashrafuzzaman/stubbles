class Activity < ActiveRecord::Base
  attr_accessible :name, :done_by_id

  belongs_to :done_by, :class_name => "User"
end