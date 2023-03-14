json.count @followees.count
json.followees @followees do |followee|
  json.partial! 'users/user', user: followee
end
