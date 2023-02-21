class FollowController < ApplicationController
  def followers
    render json: { count: current_user.followers.count, followers: current_user.followers.map(&:render) }
  end

  def followees
    render json: { count: current_user.followees.count, followees: current_user.followees.map(&:render) }
  end

  def create_follow
    return unless followees_exists?(params['user_id'])

    if current_user.id == params['user_id']
      render json: { error: 'cannot follow self' }
      return
    end

    followed_user = User.find(params['user_id'])
    if current_user.followees.include?(followed_user)
      render json: { error: 'already following' }
      return
    end
    current_user.followees << followed_user
    render json: { action: 'success', followees: followed_user.render}
  end

  def delete_follow
    return unless followees_exists?(params['user_id'])

    followed_user = User.find(params['user_id'])
    if current_user.followees.include?(followed_user)
      current_user.followees.delete(followed_user)
      render json: { action: 'success', followees: followed_user.render }
    else
      render json: { error: 'not following' }
    end
  end

  private

  def followees_exists?(followee_id)
    if User.exists?(followee_id)
      true
    else
      render json: { error: 'user does not exist' }
      false
    end
  end
end
