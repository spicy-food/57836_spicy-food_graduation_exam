class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :coffee_records, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_coffee_records, through: :bookmarks, source: :coffee_record
  validates :name, presence: true

  # 管理者判定メソッド
  def admin?
    email == 'guuuuumi93@gmail.com'
  end

  # Google OAuth2用のメソッド
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end
end