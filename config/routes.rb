Blog::Application.routes.draw do

  scope format: true, constraints: { format: :json } do
    resources :posts do
      resources :comments, only: :index
    end
    resources :comments, only: :create
  end

  resources :tags, only: :show

  root to: 'home#index'

end
