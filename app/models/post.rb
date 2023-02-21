class Post < ApplicationRecord
  belongs_to :user
  belongs_to :music
  belongs_to :mood
  has_many :likes, dependent: :destroy
end
