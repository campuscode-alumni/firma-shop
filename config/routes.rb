Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :product_ads, only: [:new, :show]
  post 'sales_ad', to: 'product_ads#create_sales_ad'
end
