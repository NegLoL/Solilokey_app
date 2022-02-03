class Post < ApplicationRecord
  #userに外部キーを紐づけた
  belongs_to :user
  has_many :likes

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, 
                      length: { maximum: 140 }
  def self.search(keyword)
    where("content like ?", "%#{keyword}%")
  end
end
