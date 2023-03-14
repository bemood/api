json.count @likes.count
json.likes do
  json.array! @likes do |like|
    json.partial! 'likes/like', like: like, current_user: @current_user
  end
end
