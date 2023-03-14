require 'json'

class UserController < ApplicationController
  def index
    @users = User.all
    render 'users/index'
  end

  def me
    @user = User.find(current_user.id)
    render 'users/me'
  end

  def update
    current_user.update(user_params)
    @user = current_user
    render 'users/me'
  end

  def delete
    if current_user.destroy
      render 'informations/success'
    else
      render 'informations/error'
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :image)
  end
end
