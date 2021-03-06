Rails.application.routes.draw do
  get 'items/index'
  devise_for :users

  # root should redirect to the login page,
  # as we don't accept users not logged in to access our content
  root to: 'landing#index'
  # root to: 'devise/sessions#new'

  resources :trips, only: [:index, :new, :edit, :update, :create, :show, :destroy] do
    member do
      get :invite
    end
    resources :chatrooms, only: :show do
      resources :messages, only: :create
    end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :items, only: [:index, :new, :create, :edit, :update, :destroy] do
      collection do
        get :form
      end
      resources :votes, only: [:create]
      patch 'update_to_booked', to: 'items#update_to_booked'
    end
  end
  resources :votes, only: [:destroy]

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  get 'uikit', to: 'uikits#index'
  # get 'landing', to: 'landing#index'

  patch "regenerate_invite_link/:id", to: "trips#regenerate_invite_link", as: :regenerate_invite_link
  get "email", to: "trips#email"
end
