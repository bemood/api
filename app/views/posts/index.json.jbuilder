json.array! @posts do |post|
  json.partial! 'posts/post', post: post, current_user: @current_user
end
