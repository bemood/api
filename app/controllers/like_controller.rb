class LikeController < ApplicationController
  def my_likes
    @likes = current_user.likes
    @current_user = current_user
    render 'likes/index'
  end

  def post_likes
    @error = 'Post does not exist'
    return render 'informations/error' unless Post.exists?(params['post_id'])

    @likes = Like.where(post_id: params['post_id'])
    @current_user = current_user
    render 'likes/index'

  end

  def create_like
    @error = 'Post does not exist'
    return render 'informations/error' unless Post.exists?(params['post_id'])

    post = Post.find(params['post_id'])
    if current_user.likes.where(post_id: post.id).count >= 1
      @error = 'Already liked'
      render 'informations/error'
    else
      current_user.likes.create(post_id: post.id)
      @success = 'Liked'
      render 'informations/success'
    end
  end

  def delete_like
    @error = 'Post does not exist'
    return render 'informations/error' unless Post.exists?(params['post_id'])

    post = Post.find(params['post_id'])
    if current_user.likes.where(post_id: post.id).count >= 1
      current_user.likes.where(post_id: post.id).destroy_all
      @success = 'Unliked'
      render 'informations/success'
    else
      @error = 'Not liked'
      render 'informations/error'
    end
  end
end
