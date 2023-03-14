json.id post.id
json.creator do
  json.partial! "users/user", user: post.user
end
json.music do
  json.partial! "musics/music", music: post.music
end
json.mood do
  json.partial! "moods/mood", mood: post.mood
end
json.likes post.likes.count
json.liked post.likes.where(user_id: current_user.id).exists?
