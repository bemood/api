class FollowController < ApplicationController
  def followers
    render json: current_user.followers.map { |user| { id: user.id, name: user.name } }
  end

  def followees
    render json: current_user.followees.map { |user| { id: user.id, name: user.name } }
  end

  def create_follow
    response = JSON.parse(request.body.read)[0]
    return unless followees_exists?(response['followee_id'])

    if current_user.id == response['followee_id']
      render json: { error: 'cannot follow self' }
      return
    end

    followed_user = User.find(response['followee_id'])
    if current_user.followees.include?(followed_user)
      render json: { error: 'already following' }
      return
    end
    current_user.followees << followed_user
    render json: { action: 'success' }
  end

  def delete_follow
    response = JSON.parse(request.body.read)[0]
    return unless followees_exists?(response['followee_id'])

    followed_user = User.find(response['followee_id'])
    if current_user.followees.include?(followed_user)
      current_user.followees.delete(followed_user)
      render json: { action: 'success' }
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
