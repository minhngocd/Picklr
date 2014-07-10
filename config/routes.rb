Rails.application.routes.draw do
  devise_for :users
  root to: "features#all"

  get '/features' => 'features#all'
  get '/features/:env' => 'features#show'
  get '/features/:env/:feature' => 'features#show_toggle'
  post '/features/:env/:feature' => 'features#toggle'
end
