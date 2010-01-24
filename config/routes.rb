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

  map.register 'register', :controller => 'users', :action => 'new'
  map.active_user 'active_user/:perishable_token', :controller => 'active_users', :action => 'active'
  
  map.resource :user_session, :as => 'session'
  map.resource :account, :controller => 'users'

  # Home
  map.root :controller => 'home', :action => 'index'
end

