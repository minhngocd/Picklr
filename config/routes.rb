Rails.application.routes.draw do
  devise_for :users
  root to: "environments#all"

  #Browsing
  get '/environments' => 'environments#all'               #show all available environments
  get '/environments/:env' => 'toggles#all'                 #html+json all toggles for env
  get '/environments/:env/:feature' => 'toggles#show' #json single toggle for env

  #Toggle Management
  post '/features/:env/:feature' => 'features#toggle'     #action toggle given toggle

  #Feature Management
  get '/feature/new' => 'features#new_feature'            #new feature
  post '/feature/new' => 'features#create_feature'        #create new feature
  get 'feature/edit/:feature' => 'features#edit_feature'  #set toggle value for feature for all envs
  put 'feature/edit/:feature' => 'features#update_feature'  #set toggle value for feature for all envs

  #Environment Management
  get '/environment/new' => 'features#new_environment'      #new environment
  post '/environment/new' => 'features#create_environment'  #create environment
                                                            #set toggle value for environment for all features
end
