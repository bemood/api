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
    Music.exists? name: response['name'] ? music = Music.where(name: response['name']).first : music = Music.create(name: response['name'])
    post = current_user.posts.create(music_id: music.id, mood_id: response['mood_id'])
    post ? render(json: { action: 'success' }) : render(json: { action: 'failure' })
  end

  def delete_post
    response = JSON.parse(request.body.read)[0]
    return unless post_exist?(response)

    post = Post.find(response['post_id'])
    if post.user_id == current_user.id
      post.destroy
      render json: { action: 'success' }
    else
      render json: { error: 'not your post' }
    end
  end

  def my_posts
    posts = current_user.posts
    render json: posts.map { |post| { id: post.id, name: post.music.name, created_at: post.created_at } }
  end

  def daily_posts
    followees = current_user.followees
    posts = Post.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day, user_id: followees)
    render json: posts
  end

  private

  def post_exist?(response)
    if Post.exists? response['post_id']
      true
    else
      render json: { error: 'post does not exist' }
      false
    end
  end
end
