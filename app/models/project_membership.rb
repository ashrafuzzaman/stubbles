class ProjectMembership < ActiveRecord::Base
  attr_accessible :user_id, :role

  belongs_to :project
  belongs_to :user

  validates :role, :inclusion => { :in => Role::all, :message => "%{value} is not a valid role" }
  validate :ensure_one_membership_in_projects
  scope :of, lambda { |user| where(:user_id => user) }

  scope :active, where(:active => true)

  def activate
  	update_attribute(:active, true)
  end

  def deactivate
  	update_attribute(:active, false)
  end

  Role::all.each do |role_name|
  	define_method "is_#{role_name}?" do
    	self.role == role_name
 		end
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