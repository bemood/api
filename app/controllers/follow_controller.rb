class FollowController < ApplicationController
  def followers
    @followers = current_user.followers
    render 'follows/followers'
  end

  def followees
    @followees = current_user.followees
    render 'follows/followees'
  end

  def create_follow
    @error = followees_condition[:message]
    return render 'informations/error' if @error

    current_user.followees << User.find(params['user_id'])
    @success = 'Followed'
    render 'informations/success'
  end

  def delete_follow
    @error = 'Followees does not exist' unless User.exists?(params['user_id'])
    return render 'informations/error' if @error

    @error = 'Not following' unless current_user.followees.include?(User.find(params['user_id']))
    return render 'informations/error' if @error

    current_user.followees.delete(User.find(params['user_id']))
    @success = 'Unfollowed'
    render 'informations/success'
  end

  private

  def followees_condition
    return { error: true, message: 'Followees does not exist' } unless User.exists?(params['user_id'])

    return { error: true, message: 'Cannot follow self' } if current_user.id == params['user_id'].to_i

    return { error: true, message: 'Already following' } if current_user.followees.include?(User.find(params['user_id']))

    { error: false, message: nil }
  end
end
