ActionController::Routing::Routes.draw do |map|
  # Jammit
  Jammit::Routes.draw(map)

  # Content
  map.resources :users, :except => :destroy
  map.resources :projects, :only => :index
  map.resources :meetings

  # Login
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.activate 'activate/:perishable_token', :controller => 'users', :action => 'activate'
  
  map.register 'register', :controller => 'users', :action => 'new'
  
  map.resource :user_session, :as => 'session'

  # Home
  map.root :controller => 'home', :action => 'index'
end

