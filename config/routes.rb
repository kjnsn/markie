Rails.application.routes.draw do
  devise_for :users
  resources :bookmarks
  root 'bookmarks#index'
  get "*all", to: 'bookmarks#create'
end
