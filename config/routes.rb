ActionController::Routing::Routes.draw do |map|
  # Jammit
  Jammit::Routes.draw(map)

  # Content
  map.resources :members, :only => [:index, :show]
  map.resources :projects, :meetings, :only => :index

  # Home
  map.root :controller => 'home', :action => 'index'
end

