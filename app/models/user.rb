class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_many :experiences, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :wishlisted_experiences, through: :wishlists, source: :experience
  has_many :roadmaps, dependent: :destroy
  has_attachment :avatar
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :avatar, presence: true
  after_create :send_welcome_email

  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.avatar_url = auth.info.image
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end


 private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
