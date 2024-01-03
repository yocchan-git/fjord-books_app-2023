Rails.application.routes.draw do
  devise_for :users
  root to: 'books#index'
  resources :books do
    resources :comments, only: :create, module: :books
  end
  resources :reports do
    resources :comments, only: :create, module: :reports
  end
  resources :users, only: %i(index show)
  resources :comments, only: :destroy
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
