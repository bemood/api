class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    result = JSON.parse(request.body.read)[0]
    command = AuthenticateUser.call(result['email'], result['password'])

    if command.success?
      render(json: { auth_token: command.result[:token], user: command.result[:user].render })
    else
      render(json: { error: command.errors }, status: :unauthorized)
    end
  end

  def create_user
    result = JSON.parse(request.body.read)[0]
    new_user = User.new(result)
    new_user.save ? render(json: new_user.render) : render(json: { error: 'User not created' })
  end

  def image_user
    @user = User.find(params[:id])
    send_data Base64.decode64(@user.image), type: 'image/png', disposition: 'inline'
  end
end
