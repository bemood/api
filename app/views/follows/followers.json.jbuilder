json.count @followers.count
json.followers @followers do |follower|
  json.partial! 'users/user', user: follower
end
