class PostController < ApplicationController
  def new_post
    response = JSON.parse(request.body.read)
    return new_post_unrespect_condition(response) if new_post_unrespect_condition(response)

    music = get_music(response['music_id'])
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

  def new_post_unrespect_condition(response)
    if current_user.posts.where(created_at: Time.now.beginning_of_day..Time.now.end_of_day).count >= 1
      return render json: { error: 'already posted today' }
    end
    return render json: { error: 'mood does not exist' } unless Mood.exists? id: response['mood_id']

    false
  end

  def get_music(id_spotify)
    if Music.exists? spotify_id: id_spotify
      Music.where(spotify_id: id_spotify).first
    else
      Music.create(spotify_id: id_spotify)
    end
  end
end
