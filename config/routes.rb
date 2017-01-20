Rails.application.routes.draw do
  resources :files, only: [:index, :show]

  root "files#index"
end
