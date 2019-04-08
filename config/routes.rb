Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :sales_ads, only: [:new, :show, :create] do
    member do
      post 'conversation', to: 'conversations#create'
    end
  end

  resources :conversations, only: [:show] do
    resources :messages, only: [:create]
  end

  namespace 'api', defaults: { format: 'json' } do
    namespace 'v1' do

      resources :product_ads, only: [:index, :destroy]
      resources :users, only: [:index, :destroy]
    end
  end
end
