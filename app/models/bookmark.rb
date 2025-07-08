class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :coffee_record

  validates :user_id, uniqueness: { scope: :coffee_record_id }
end
