json.id like.id
json.post do
  json.partial! 'posts/post', post: like.post, current_user: current_user
end
