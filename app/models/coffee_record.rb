class CoffeeRecord < ApplicationRecord
  belongs_to :user
  
  mount_uploader :image, ImageUploader

  validates :origin, presence: true
  validates :bean_type, presence: true
  validates :process_method, presence: true
  validates :roast_level, presence: true, inclusion: { in: %w[Dark Medium Light] }
  validates :acidity_level, presence: true, inclusion: { in: %w[High Medium Low] }
  validates :body_level, presence: true, inclusion: { in: %w[Full Medium Light] }
end 