namespace :v1 do
  resources :users, only: %i(show)
end
