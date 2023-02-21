Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post 'api/authenticate', to: 'authentication#authenticate'

  # Routes for the User resource:
  get 'api/users', to: 'user#users'
  post 'api/users/new', to: 'authentication#create_user'
  get 'api/users/me', to: 'user#me'
  delete 'api/users/me', to: 'user#delete'

  # Routes for Friend resource:
  # followers = Who follow me
  get 'api/follows/followers', to: 'follow#followers'
  post 'api/follows/followers', to: 'follow#create_follow'
  delete 'api/follows/followers', to: 'follow#delete_follow'
  # followees = Who I follow
  get 'api/follows/followees', to: 'follow#followees'

  # Routes for Post resource:
  post 'api/posts', to: 'post#new_post'
  get 'api/posts/daily', to: 'post#daily_posts'
  get 'api/posts/me', to: 'post#my_posts'
  delete 'api/posts', to: 'post#delete_post'

  # Routes for Like resource:
  post 'api/likes', to: 'like#create_like'
  delete 'api/likes', to: 'like#delete_like'
  get 'api/likes/me', to: 'like#my_likes'
  get 'api/likes/post', to: 'like#post_likes'
end
