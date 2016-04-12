Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions", omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#landing_page'

  post "/" => 'pages#save_email'

  get "contact" => "pages#contact"
  post "contact" => "pages#contact_mail"

  get "cgu" => "pages#cgu"

  mount Attachinary::Engine => "/attachinary"

  resources :experiences do
    post "send_experience" => "experiences#send_experience", as: 'send'
    resources :ratings, only: [:create]
    resources :wishlists, only: [:create]
  end

  post "gps_coordinates" => "images#get_gps"

  resources :roadmaps do
    get "send_roadmap" => "roadmaps#send_roadmap", as: 'send'
    resources :experiences do
      resources :activities, only: [:create]
    end
  end

  resources :roadmaps
  resources :activities, only: [:update, :destroy]

  get "my_experiences" => "experiences#my_experiences"

  resources :wishlists, only: [:index, :destroy]
  resources :ratings, only: [:destroy]
 end
