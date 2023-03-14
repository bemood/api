json.success @success
if @success
  json.user do
    json.partial! 'users/user', user: @user
  end
end
