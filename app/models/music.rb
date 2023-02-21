class Music < ApplicationRecord
  has_many :posts

  def render
    return {
      id: self.id,
      name: self.name
    }
  end
end
