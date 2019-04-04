Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :product_ads, only: [:new, :show]
  post 'sales_ad', to: 'product_ads#create_sales_ad'

  namespace 'api', defaults: { format: 'json' } do
    namespace 'v1' do
      resources :product_ads, only: [:index, :destroy]
    end
  end
end
