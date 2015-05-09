Rails.application.routes.draw do

  root "dashboard#index"

  #USER ROUTES
  resources :user
  get "register", to: "user#new", :as => "register"
  post "register", to: "user#create"

  #DASHBOARD ROUTES
  resources :dashboard

  #CONVERSATION ROUTES
  resources :conversation

  #CONTACT ROUTES
  resources :contact
  get "search", to: "contact#search"
  post "search", to: "contact#search"

  #MESSAGE ROUTES
  resources :message

  #STATUS ROUTES
  resources :status

  #SESSION ROUTES
  resources :session
  get "login", to: "session#index", :as => "login"
  post "login", to: "session#create"
  get "logout", to: "session#destroy", :as => "logout"

end
