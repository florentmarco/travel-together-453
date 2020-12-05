Rails.application.routes.draw do
  get 'items/index'
  devise_for :users

  # root should redirect to the login page,
  # as we don't accept users not logged in to access our content
  root to: 'trips#index'
  # root to: 'devise/sessions#new'

  resources :trips, only: [:index, :new, :edit, :update, :create, :show, :destroy] do
    resources :messages, only: :create

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :items, only: [:index, :new, :create] do
      resources :votes, only: [:create]
    end
  end

  resources :votes, only: [:destroy]

  get 'uikit', to: 'uikits#index'

  patch "regenerate_invite_link/:id", to: "trips#regenerate_invite_link", as: :regenerate_invite_link
  get "email", to: "trips#email"

end
