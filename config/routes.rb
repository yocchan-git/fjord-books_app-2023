Rails.application.routes.draw do
  resources :reports do
    resource :comments, only: %i(create destroy)
  end
  # post 'comments', to: "comments#create", as: "comments"
  # delete 'comments/:id', to: "comments#destroy", as: "comment"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books do
    resource :comments, only: %i(create destroy)
  end
  resources :users, only: %i(index show)
end
