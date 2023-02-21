class PostController < ApplicationController

  def new_post
    response = JSON.parse(request.body.read)[0]
    if current_user.posts.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day).count >= 1
      render json: { error: 'already posted today' }
      return
    end
    music = Music.where(name: response['name']).first
    if music
      post = current_user.posts.create(music_id: music.id)
    else
      music = Music.create(name: response['name'])
      post = current_user.posts.create(music_id: music.id)
    end

    if post
      render json: { action: 'success' }
    else
      render json: { action: 'failure' }
    end
  end

  def delete_post
    response = JSON.parse(request.body.read)[0]
    if Post.exists? id: response['post_id']
      post = Post.find(response['post_id'])
      if post.user_id == current_user.id
        post.destroy
        render json: { action: 'success' }
      else
        render json: { error: 'not your post' }
      end
    else
      render json: { error: 'post does not exist' }
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
end
