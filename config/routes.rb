ActionController::Routing::Routes.draw do |map|
  map.resources :members, :only => [:index, :show]
  map.resources :projects, :only => :index

  map.root :controller => 'home', :action => 'index'
end

