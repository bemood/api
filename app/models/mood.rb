class Mood < ApplicationRecord
  has_many :posts

  def render
    return {
      id: self.id,
      definition: self.definition,
      emojie: self.emojie
    }
  end
end
