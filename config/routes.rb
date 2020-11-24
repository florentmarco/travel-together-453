Rails.application.routes.draw do
  devise_for :users

  # root should redirect to the login page,
  # as we don't accept users not logged in to access our content
  root to: 'pages#home'

  resources :trips, only: [:index, :new, :edit, :update, :create, :show, :destroy]
end
