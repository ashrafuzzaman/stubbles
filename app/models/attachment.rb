class Attachment < ActiveRecord::Base
  attr_accessible :attachable_id, :attachable_type, :file, :remote_file_url
  mount_uploader :file, FileUploader
  validates :file, :presence => true

  belongs_to :attachable, polymorphic: true, touch: true
  belongs_to :uploaded_by, :class_name => "User"

  validate :validate_file_size
  after_create :set_uploaded_by

  private
  def set_uploaded_by
    self.uploaded_by ||= User.current
  end

  def validate_file_size
    upload_limit = 5
    if file.file.size.to_f/(1000*1000) > upload_limit.to_f
      errors.add(:file, "You cannot upload a file greater than #{upload_limit.to_f}MB")
    end
  end
end