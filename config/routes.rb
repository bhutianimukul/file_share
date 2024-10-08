Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "signup" => "users#new", as: :signup
  post "register" => "users#create"
  get "signin" => "sessions#new", as: :login
  post "login" => "sessions#create"
  get "signout" => "sessions#destroy", as: :logout
  delete "logout" => "sessions#destroy"
  get "upload" => "uploads#new", as: :upload_file
  post "file" => "uploads#create", as: :file
  post "upload" => "uploads#new"
  get "files" => "uploads#index"
  get "api/files" => "uploads#index", defaults: { format: :json }
  get "files/:user_id/:file_id" => "uploads#destroy", as: :user_file_delete
  delete "files/:user_id/:file_id" => "uploads#destroy"
  post "file/download/:user_id/:file_id" => "uploads#download"
  get "file/download/:user_id/:file_id" => "uploads#download", as: :user_download_option
  get "files/view/:user_id/:file_id" => "uploads#show", as: :user_view
  post "files/update/:file_id" => "uploads#update", as: :update_public
  patch "api/files/update/:file_id" => "uploads#update", defaults: { format: :json }

  resources :uploads, only: [ :show ]

  resources :users, only: [ :new, :create ]
  resources :sessions, only: [ :new, :create, :destroy ]

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "uploads#index"
end
