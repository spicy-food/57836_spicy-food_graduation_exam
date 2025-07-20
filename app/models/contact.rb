class Contact < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :subject, presence: true, length: { maximum: 100 }
  validates :message, presence: true, length: { minimum: 10, maximum: 1000 }

  # カテゴリの選択肢
  CATEGORIES = %w[
    アプリについて
    バグ報告
    機能要望
    その他
  ].freeze

  validates :category, inclusion: { in: CATEGORIES }, allow_blank: true
end
