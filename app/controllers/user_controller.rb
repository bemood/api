require 'json'

class UserController < ApplicationController
  def users
    # get all user name
    render json: User.all.map { |user| { name: user.name, email: user.email } }
  end

  def me
    render json: current_user.render
  end

  def update
    user_params = JSON.parse(request.body.read)
    current_user.update(user_params)
    render json: current_user.render
  end

  def delete
    current_user.destroy
    render json: { action: 'success' }
  end
end
