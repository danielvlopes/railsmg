ActionController::Routing::Routes.draw do |map|
  map.resources :members, :only => [:index, :show]

  map.root :controller => 'home', :action => 'index'
end

