Rails.application.routes.draw do
  root "movies#index"
  resources :movies, only: %i|index show|
end
