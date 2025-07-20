class CoffeeRecord < ApplicationRecord
  # ここに定数を追加
  ROAST_LEVELS = [
    "ライトロースト",
    "シナモンロースト",
    "ミディアムロースト",
    "ハイロースト",
    "シティロースト",
    "フルシティロースト",
    "フレンチロースト",
    "イタリアンロースト"
  ]

  belongs_to :user
  mount_uploader :image, ImageUploader

  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user

  def can_delete?(user)
    user.admin? || user == self.user
  end
end