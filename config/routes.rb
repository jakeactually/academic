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
    root "catalog#index"
    get "catalog", to: "catalog#index"
    post "careers", to: "catalog#create_career", as: :careers
    post "career_semesters", to: "catalog#create_career_semester", as: :career_semesters
    post "subjects", to: "catalog#create_subject", as: :subjects
    post "teachers", to: "catalog#create_teacher", as: :teachers
    post "classrooms", to: "catalog#create_classroom", as: :classrooms
    post "classroom_hour_slots", to: "catalog#create_classroom_hour_slot", as: :classroom_hour_slots
    post "dependent_subjects", to: "catalog#create_dependent_subject", as: :dependent_subjects
    post "career_semester_subjects", to: "catalog#create_career_semester_subject", as: :career_semester_subjects
    post "course_classes", to: "catalog#create_course_class", as: :course_classes
  end
end
