class PostController < ApplicationController
  # Voir avec JBuilder
  def new_post
    response = JSON.parse(request.body.read)
    if current_user.posts.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day).count >= 1
      return render json: { error: 'already posted today' }
    end
    return render json: { error: 'mood does not exist' } unless Mood.exists? id: response['mood_id']

    if Music.exists? spotify_id: response['spotify_id']
      music = Music.where(spotify_id: response['spotify_id']).first
    else
      music = Music.create(spotify_id: response['spotify_id'])
    end

    post = current_user.posts.create(music_id: music.id, mood_id: response['mood_id'])
    post ? render(json: { action: 'success', post: post.render(current_user) }) : render(json: { error: 'failure' })
  end

  def delete_post
    return unless post_exist?(params['post_id'])

    post = Post.find(params['post_id'])
    if post.user_id == current_user.id
      post.destroy
      render json: { action: 'success', post: post.render(current_user) }
    else
      render json: { error: 'not your post' }
    end
  end

  def my_posts
    posts = current_user.posts
    render json: { count: posts.count, posts: posts.map { |post| post.render(current_user) } }
  end

  def daily_posts
    followees = current_user.followees
    posts = Post.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day, user_id: followees)
    render json: posts.map { |post| post.render(current_user) }
  end

  def my_daily_posts
    post = current_user.posts.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day).first
    render json: post.render(current_user)
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
