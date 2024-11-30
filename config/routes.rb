Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  # Маршрут для перевірки стану сервера
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Маршрути для продуктів
  resources :products do
    resources :reviews, only: [:create]
  end
  
  # Кореневий маршрут
  root "home#index"

  # Маршрути для кошика
  resource :cart, only: [:show] do
    post 'add_item', to: 'carts#add_item'
    delete 'remove_item/:id', to: 'carts#remove_item', as: 'remove_item'
  end

  # Маршрути для замовлень
  resources :orders, only: [:new, :create, :show]

  # Маршрути для контактних повідомлень
  resources :contact_messages, only: [:index, :create, :new]


  # Маршрути для контактної сторінки
  get 'contact', to: 'contact_messages#new'
  post 'contact', to: 'contact_messages#create'

  # Додаткові маршрути для кошика
  patch 'cart/select_delivery', to: 'carts#select_delivery'
  patch 'cart/update', to: 'carts#update_cart', as: :update_cart

  # Маршрути для платежів
  post 'checkout', to: 'payments#create'

  # Кастомний маршрут для виходу з акаунта
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
