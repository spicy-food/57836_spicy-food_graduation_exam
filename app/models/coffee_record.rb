class CoffeeRecord < ApplicationRecord
  belongs_to :user
  
  mount_uploader :image, ImageUploader

  validates :origin, presence: false
  validates :bean_type, presence: false
  validates :process_method, presence: false
  validates :roast_level, presence: false
  validates :acidity_level, presence: false
  validates :body_level, presence: false
  validates :notes, presence: false
end 