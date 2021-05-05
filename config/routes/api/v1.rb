namespace :v1 do
  resources :users do
    get :me, on: :collection
  end

  post '/auth/facebook', to: 'authentication#facebook'
end
