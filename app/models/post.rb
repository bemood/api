class Post < ApplicationRecord
  belongs_to :user
  belongs_to :music
  belongs_to :mood
  has_many :likes, dependent: :destroy

  def render
    return {
      id: self.id,
      creator: self.user.render,
      music: self.music.render,
      mood: self.mood.render,
      like_count: self.likes.count,
      created_at: self.created_at
    }
  end
end
