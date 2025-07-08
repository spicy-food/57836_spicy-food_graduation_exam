class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :coffee_records, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_coffee_records, through: :bookmarks, source: :coffee_record
  validates :name, presence: true
end
