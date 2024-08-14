Rails.application.routes.draw do
  # Devise routes for user authentication, registration, and sessions
  devise_for :users, controllers: { 
    registrations: "users/registrations", 
    sessions: "users/sessions",
    invitations: 'devise/invitations' 
  }

  # Root route
  root "articles#index"

  # Nested routes for articles and comments
  resources :articles do
    resources :comments
  end

  # Routes for organizations, including custom member route for inviting users
  resources :organizations do
    member do
      post :invite_user
    end
  end
end
