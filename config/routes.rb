Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  
  resources :coffee_records do
    resource :bookmark, only: [:create, :destroy]
  end
  
  resources :bookmarks, only: [:index]
  
  # お問い合わせフォーム
  get 'contact', to: 'contacts#new'
  post 'contact', to: 'contacts#create'
  get 'contact/thanks', to: 'contacts#show'
  
  # 管理者ページ
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :contacts, only: [:index, :show]
  end

  # 静的ページ
  get 'privacy-policy', to: 'pages#privacy_policy'
  get 'terms-of-service', to: 'pages#terms_of_service'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end