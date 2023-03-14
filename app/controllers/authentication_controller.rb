class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    command = AuthenticateUser.call(auth_params[:email], auth_params[:password])

    @success = command.success?
    @error = command.errors

    return render 'informations/error' unless @success

    @user = command.result[:user]
    @token = command.result[:token]
  end

  # def create_user
  #   result = JSON.parse(request.body.read)
  #   new_user = User.new(result)
  #   new_user.save ? render(json: new_user.render) : render(json: { error: 'User not created' })
  # end

  def create_user
    @user = User.new(
      user_params
    )
    @success = @user.save
    @error = @user.errors

    return render 'informations/error' unless @success
  end

  def image_user
    @user = User.find(params[:id])
    send_data Base64.decode64(@user.image), type: 'image/png', disposition: 'inline'
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :image)
  end

  def auth_params
    params.permit(:email, :password)
  end

end
