Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :sales_ads, only: [:new, :show, :create]

  namespace 'api', defaults: { format: 'json' } do
    namespace 'v1' do

      resources :product_ads, only: [:index, :destroy]
      resources :users, only: [:index, :destroy]
    end
  end
end
