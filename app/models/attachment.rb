class Attachment < ActiveRecord::Base
  attr_accessible :attachable_id, :attachable_type, :file, :remote_file_url
  mount_uploader :file, FileUploader
  validates :file, :presence => true

  belongs_to :attachable, polymorphic: true
  belongs_to :uploaded_by, :class_name => "User"
end