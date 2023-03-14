json.auth_token @token
json.user do
  json.partial! 'users/user', user: @user
end
