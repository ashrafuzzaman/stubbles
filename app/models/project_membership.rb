class ProjectMembership < ActiveRecord::Base
  attr_accessible :user_id

  belongs_to :project, touch: true
  belongs_to :user

  validate :ensure_one_membership_in_projects

  scope :of, lambda { |user| where(:user_id => user) }
  scope :active, -> { where(:active => true) }

  def activate
  	update_attribute(:active, true)
  end

  def deactivate
  	update_attribute(:active, false)
  end

  private
  def ensure_one_membership_in_projects
  	if user.nil?
      errors.add(:user, 'not found')
    elsif project.memberships.of(user).count > 0
      errors.add(:user, 'already a member')
    end
  end
end