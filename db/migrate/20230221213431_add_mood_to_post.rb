class AddMoodToPost < ActiveRecord::Migration[7.0]
  # Create relationship between posts and mood
  def change
    add_reference :posts, :mood, null: false, foreign_key: true
  end
end
