class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def render
    return {
      id: self.id,
      user: self.user.render,
      post: self.post.render
    }
  end
end
