class PostController < ApplicationController
  # Voir avec JBuilder
  def new_post
    response = JSON.parse(request.body.read)
    if current_user.posts.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day).count >= 1
      @error = 'already posted today'
      return render 'informations/error'
    end
    unless Mood.exists? id: response['mood_id']
      @error = 'mood does not exist'
      return render 'informations/error'
    end

    if Music.exists? spotify_id: response['spotify_id']
      music = Music.where(spotify_id: response['spotify_id']).first
    else
      music = Music.create(spotify_id: response['spotify_id'])
    end

    @post = current_user.posts.create(music_id: music.id, mood_id: response['mood_id'])
    if @post
      @user = current_user
      render 'posts/new_post'
    else
      @error = 'failure'
      render 'informations/error'
    end
  end

  def delete_post
    @error = 'Post does not exist'
    return render 'informations/error' unless post_exist?(params['post_id'])

    post = Post.find(params['post_id'])
    if post.user_id == current_user.id
      post.destroy
      @success = 'Post deleted'
      render 'informations/success'
    else
      @error = 'You are not the owner of this post'
      render 'informations/error'
    end
  end

  def my_posts
    @posts = current_user.posts
    @current_user = current_user
    render 'posts/index'
  end

  def daily_posts
    followees = current_user.followees
    @posts = Post.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day, user_id: followees)
    @current_user = current_user
    render 'posts/index'
  end

  def my_daily_posts
    @post = current_user.posts.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day).first
    @current_user = current_user
    render 'posts/show'
  end

  private

  def post_exist?(post_id)
    if Post.exists? post_id
      true
    else
      render json: { error: 'post does not exist' }
      false
    end
  end
end
