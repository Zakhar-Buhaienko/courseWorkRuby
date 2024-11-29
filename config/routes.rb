Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :products
  
  root "home#index"

  resource :cart, only: %i[show] do
    post 'add_item', to: 'carts#add_item'
    delete 'remove_item/:id', to: 'carts#remove_item', as: 'remove_item'
  end

  resources :products do
    resources :reviews, only: %i[create]
  end

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get 'contact', to: 'contact_messages#new'
  post 'contact', to: 'contact_messages#create'

  patch 'cart/select_delivery', to: 'carts#select_delivery'

  post 'checkout', to: 'payments#create'

  # Defines the root path route ("/")
  
  # root "posts#index"
end
