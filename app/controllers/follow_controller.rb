class FollowController < ApplicationController
  def followers
    render json: current_user.followers
  end

  def followees
    render json: current_user.followees
  end

  def create_follow
    response = JSON.parse(request.body.read)[0]
    followed_user = User.find(response['followee_id'])
    if response['followee_id'] == current_user.id
      render json: { error: 'cannot follow self' }
    elsif current_user.followees.include?(followed_user)
      render json: { error: 'already following' }
    else
      current_user.followees << followed_user
      render json: { action: 'success' }
    end
  end

  def delete_follow
    response = JSON.parse(request.body.read)[0]
    followed_user = User.find(response['followee_id'])
    if current_user.followees.include?(followed_user)
      current_user.followees.delete(followed_user)
      render json: { action: 'success' }
    else
      render json: { error: 'not following' }
    end
  end
end
