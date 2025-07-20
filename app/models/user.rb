class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :coffee_records, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_coffee_records, through: :bookmarks, source: :coffee_record
  validates :name, presence: true

  def admin?
    email == 'guuuuumi93@gmail.com'  # 管理者のメールアドレスを指定
  end
end
