class User < ApplicationRecord
    #各外部キーに紐づける
    has_many :posts
    has_many :privateposts
    has_many :likes
    
    before_save { email.downcase! }
    has_secure_password
    attribute :image_name, :string, default: 'default_user.jpg'

    validates :name, presence: true, 
                     length: { maximum: 50 }

    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, 
                      length: { maximum: 255 },
                      format: { with: EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
                      
    validates :password, presence: true,
                         length: { minimum: 6 }

end
