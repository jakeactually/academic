Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  root "home#index"

  get "login", to: "sessions#new", as: :login
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: :logout

  namespace :admin do
    root "dashboard#index"

    resources :careers, only: [ :index, :create, :destroy ]
    resources :career_subjects, only: [ :index, :create, :destroy ]
    resources :subjects, only: [ :index, :create, :destroy ]
    resources :teachers, only: [ :index, :create, :destroy ]
    resources :classrooms, only: [ :index, :create, :destroy ]
    resources :teacher_subjects, only: [ :index, :create, :destroy ]
    resources :dependent_subjects, only: [ :index, :create, :destroy ]
    resources :course_classes, only: [ :index, :create, :destroy ]
  end
end
