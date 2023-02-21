class LikeController < ApplicationController
  def my_likes
    likes = current_user.likes
    render json: likes.map { |like| { id: like.id, post_id: like.post_id, created_at: like.created_at } }
  end

  def post_likes
    response = JSON.parse(request.body.read)[0]
    post = Post.find(response['post_id'])
    likes = post.likes
    render json: likes.map { |like| { id: like.id, user_id: like.user_id, created_at: like.created_at } }
  end

  def create_like
    response = JSON.parse(request.body.read)[0]
    post = Post.find(response['post_id'])
    if current_user.likes.where(post_id: post.id).count >= 1
      render json: { error: 'already liked' }
    else
      current_user.likes.create(post_id: post.id)
      render json: { action: 'success' }
    end
  end

  def delete_like
    response = JSON.parse(request.body.read)[0]
    post = Post.find(response['post_id'])
    if current_user.likes.where(post_id: post.id).count >= 1
      current_user.likes.where(post_id: post.id).destroy_all
      render json: { action: 'success' }
    else
      render json: { error: 'not liked' }
    end
  end
end
