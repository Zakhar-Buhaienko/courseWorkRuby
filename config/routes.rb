Rails.application.routes.draw do
  devise_for :users

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
  resources :orders, only: [:new, :create, :show]

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get 'contact', to: 'contact_messages#new'
  post 'contact', to: 'contact_messages#create'

  patch 'cart/select_delivery', to: 'carts#select_delivery'
  patch 'cart/update', to: 'carts#update_cart', as: :update_cart

  post 'checkout', to: 'payments#create'

end
