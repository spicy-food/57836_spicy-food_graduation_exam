Rails.application.routes.draw do
  namespace :admin do
    get 'contacts/index'
    get 'contacts/show'
  end
  get 'contacts/new'
  get 'contacts/create'
  get 'contacts/show'
  root 'home#index'
  devise_for :users
  
  resources :coffee_records do
    resource :bookmark, only: [:create, :destroy]
  end
  
  resources :bookmarks, only: [:index]
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'privacy-policy', to: 'pages#privacy_policy'
  get 'terms-of-service', to: 'pages#terms_of_service'
  # お問い合わせフォーム
  get 'contact', to: 'contacts#new'
  post 'contact', to: 'contacts#create'
  get 'contact/thanks', to: 'contacts#show'
  # 管理者ページ
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :contacts, only: [:index, :show]
  end
end