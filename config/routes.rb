Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post 'api/authenticate', to: 'authentication#authenticate'

  # Routes for the User resource:
  post 'api/users', to: 'authentication#create_user'
  get 'api/users', to: 'user#users'
  get 'api/me/users', to: 'user#me'
  delete 'api/me/users', to: 'user#delete'

  # Routes for Friend resource:
  # followers = Who follow me
  get 'api/me/followers', to: 'follow#followers'
  post 'api/follows/:user_id', to: 'follow#create_follow'
  delete 'api/follows/:user_id', to: 'follow#delete_follow'
  # followees = Who I follow
  get 'api/me/followees', to: 'follow#followees'

  # Routes for Post resource:
  post 'api/posts', to: 'post#new_post'
  get 'api/posts/daily', to: 'post#daily_posts'
  get 'api/me/posts', to: 'post#my_posts'
  delete 'api/posts/:post_id', to: 'post#delete_post'
  get 'api/me/posts/daily', to: 'post#my_daily_posts'

  # Routes for Like resource:
  post 'api/likes/:post_id', to: 'like#create_like'
  delete 'api/likes/:post_id', to: 'like#delete_like'
  get 'api/me/likes', to: 'like#my_likes'
  get 'api/posts/:post_id/likes', to: 'like#post_likes'

  # Routes for Mood resource:
  get 'api/moods', to: 'mood#all_moods'
end
