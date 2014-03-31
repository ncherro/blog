Blog::Application.routes.draw do

  scope defaults: { format: :json } do
    resources :posts, only: [:index, :show, :create] do
      resources :comments, only: [:index, :create]
    end
  end

  resources :tags, only: :show

  root to: 'home#index'

end
