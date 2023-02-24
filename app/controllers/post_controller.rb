class PostController < ApplicationController

  def new_post
    response = JSON.parse(request.body.read)[0]
    if current_user.posts.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day).count >= 1
      render json: { error: 'already posted today' }
      return
    end
    unless Mood.exists? id: response['mood_id']
      render json: { error: 'mood does not exist' }
      return
    end
    Music.exists? spotify_id: response['spotify_id'] ? music = Music.where(spotify_id: response['spotify_id']).first : music = Music.create(spotify_id: response['spotify_id'])
    post = current_user.posts.create(music_id: music.id, mood_id: response['mood_id'])
    post ? render(json: { action: 'success', post: post.render }) : render(json: { action: 'failure' })
  end

  def delete_post
    return unless post_exist?(params['post_id'])

    post = Post.find(params['post_id'])
    if post.user_id == current_user.id
      post.destroy
      render json: { action: 'success', post: post.render }
    else
      render json: { error: 'not your post' }
    end
  end

  def my_posts
    posts = current_user.posts
    # render json: posts.map { |post| { id: post.id, name: post.music.name, created_at: post.created_at } }
    render json: { count: posts.count, posts: posts.map(&:render) }
  end

  def daily_posts
    followees = current_user.followees
    posts = Post.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day, user_id: followees)
    render json: posts.map(&:render)
  end

  def my_daily_posts
    posts = current_user.posts.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day)
    render json: posts.map(&:render)
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
