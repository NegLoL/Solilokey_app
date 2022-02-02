class Post < ApplicationRecord
  #userに外部キーを紐づけた
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, 
                      length: { maximum: 140 }
end