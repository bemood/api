json.partial! 'users/user', user: @user
json.followers_count @user.followers.count
json.followees_count @user.followees.count
json.likes_count @user.likes.count
