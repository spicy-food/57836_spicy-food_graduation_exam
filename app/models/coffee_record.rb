class CoffeeRecord < ApplicationRecord
  # ここに定数を追加
  ROAST_LEVELS = %w[
    ライトロースト
    シナモンロースト
    ミディアムロースト
    ハイロースト
    シティロースト
    フルシティロースト
    フレンチロースト
    イタリアンロースト
  ].freeze

  belongs_to :user
  mount_uploader :image, ImageUploader

  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user

  # バリデーションを追加
  validates :origin, presence: true
  validates :bean_type, presence: true
  validates :process_method, presence: true
  validates :roast_level, presence: true, inclusion: { in: ROAST_LEVELS }

  # 削除権限チェックメソッド
  def can_delete?(user)
    user.admin? || user == self.user
  end
end
