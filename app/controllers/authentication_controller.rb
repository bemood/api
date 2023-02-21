class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    result = JSON.parse(request.body.read)[0]
    command = AuthenticateUser.call(result['email'], result['password'])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def create_user
    new_user = User.new
    result = JSON.parse(request.body.read)[0]
    new_user.name = result['name']
    new_user.email = result['email']
    new_user.password = result['password']
    new_user.password_confirmation = result['password_confirmation']

    new_user.save ? render(json: new_user) : render(json: { error: 'User not created' })
  end

end
