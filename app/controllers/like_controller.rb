class LikeController < ApplicationController
  def my_likes
    likes = current_user.likes
    render json: { count: likes.count, likes: likes.map { |like| like.post.render } }
  end

  def post_likes
    return unless post_exist?(params['post_id'])

    post = Post.find(params['post_id'])
    render json: {count: post.likes.count, likers: post.likes.map { |like| like.user.render } }
  end

  def create_like
    return unless post_exist?(params['post_id'])

    post = Post.find(params['post_id'])
    if current_user.likes.where(post_id: post.id).count >= 1
      render json: { error: 'already liked', post: post.render }
    else
      current_user.likes.create(post_id: post.id)
      render json: { action: 'success', post: post.render }
    end
  end

  def delete_like
    return unless post_exist?(params['post_id'])

    post = Post.find(params['post_id'])
    if current_user.likes.where(post_id: post.id).count >= 1
      current_user.likes.where(post_id: post.id).destroy_all
      render json: { action: 'success', post: post.render }
    else
      render json: { error: 'not liked', post: post.render}
    end
  end

  private

  def post_exist?(post_id)
    if Post.exists?(post_id)
      true
    else
      render json: { error: 'post does not exist' }
      false
    end
  end
end
