Rails.application.routes.draw do
  devise_for :users
  root to: "environments#all"

  #Feature Management
  get   '/features/new' => 'features#new'                     #new feature
  post  '/features'     => 'features#create'                  #create new feature
  get   '/features/:feature/edit'  => 'features#edit'         #edit toggle value for feature for all envs
  put   '/features/:feature'       => 'features#update'       #update toggle value for feature for all envs

  #Environment Management
  get   '/environments'     => 'environments#all'             #show all available environments
  get   '/environments/new' => 'environments#new'             #new environment
  post  '/environments' => 'environments#create'          #create environment

  #Toggling
  get   '/environments/:env'  => 'toggles#all'                #html+json all toggles for env
  get   '/environments/:env/:feature' => 'toggles#show'       #json single toggle for env
  post  '/environments/:env/:feature' => 'toggles#toggle'     #toggle the value given toggle


end
