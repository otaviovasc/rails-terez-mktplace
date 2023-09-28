Rails.application.routes.draw do
  get 'cart', to: 'cart#show'
  post 'cart/add'
  post 'cart/remove'
  get 'cart/clear', to: 'cart#clear'
  get 'checkout', to: 'cart#checkout'
  resources :products
  root 'products#index'
end
