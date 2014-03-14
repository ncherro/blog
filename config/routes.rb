Blog::Application.routes.draw do

  resources :posts
  resources :tags, only: :show

  root to: 'home#index'

end
