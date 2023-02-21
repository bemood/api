class Post < ApplicationRecord
  belongs_to :user
  belongs_to :music
  has_many :likes, dependent: :destroy
end
