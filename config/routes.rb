Rails.application.routes.draw do
  # TODO: remove the generated routes below
  get 'items/index'
  devise_for :users

  # root should redirect to the login page,
  # as we don't accept users not logged in to access our content
  root to: 'trips#index'
  # TODO: remove unused routes
  # root to: 'devise/sessions#new'

  # TODO: the only: array is every 7 restful routes here ;)
  resources :trips, only: [:index, :new, :edit, :update, :create, :show, :destroy] do
    resources :messages, only: :create

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :items, only: [:index, :new, :create] do
      # TODO: avoid double nested routes
      # rule of thumb: 
      # - members routes => nesting e.g. items/:item_id/votes
      # - collection routes => NO nesting e.g. /votes NOT /items/votes
      resources :votes, only: [:create]
    end
  end

  resources :votes, only: [:destroy]

  get 'uikit', to: 'uikits#index'

  patch "regenerate_invite_link/:id", to: "trips#regenerate_invite_link", as: :regenerate_invite_link
  get "email", to: "trips#email"

end
