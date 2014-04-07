require 'digest/md5'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  THEMES = ['dark_theme', 'light_theme']

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me, :short_name, :theme
  validates :first_name, :last_name, :presence => true
  validates :email, :uniqueness => true
  #validates :short_name, :uniqueness => true

  has_many :stories #not meaningful as user has many stories through proects
  has_many :memberships, :class_name => 'ProjectMembership'
  has_many :projects, :through => :memberships, :source => :project
  has_and_belongs_to_many :groups

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
    "http://www.gravatar.com/avatar/#{email_hash}?s=#{size}"
  end

  def password_required?
    #super && provider.blank?
    self.encrypted_password.present?
  end

  def update_with_password(params, *options)
    if password_required?
      super
    else
      update_attributes(params, *options)
    end
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create(first_name: data["first_name"],
                         last_name: data["last_name"],
                         email: data["email"])
    end
    user
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
end