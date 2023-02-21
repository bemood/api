require 'bcrypt'

class User < ApplicationRecord
  has_secure_password
  has_secure_password :recovery_password, validations: false

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users

  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

  has_many :posts, dependent: :destroy
end
