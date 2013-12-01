require 'digest/md5'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me, :short_name
  validates :name, :presence => true
  validates :email, :uniqueness => true
  validates :short_name, :uniqueness => true

  has_many :stories #not meaningful as user has many stories through proects
  has_many :memberships, :class_name => 'ProjectMembership'
  has_many :projects, :through => :memberships, :source => :project

  def self.current=(user)
    RequestStore.store[:current_user] = user
  end

  def self.current
    RequestStore.store[:current_user]
  end

  def name
    "#{first_name} #{last_name}"
  end

  def last_accessed_project
  	projects.order("last_accessed_at DESC").try(:first)
  end

  def admin_for?(project)
  	membership = project.membership_of(self)
  	membership && membership.active && membership.is_admin?
  end

  def gravatar_url(size = 50)
    email_hash = Digest::MD5.hexdigest(self.email.downcase)
    image_src = "http://www.gravatar.com/avatar/#{email_hash}?s=#{size}"
  end

end