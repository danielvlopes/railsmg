class BaseController < ApplicationController
  inherit_resources
  before_filter :authorize_resource!
  
  protected
  
  def authorize_resource!
    object = case action_name
    when 'index'
      resource_class
    when 'new', 'create'
      build_resource
    else
      resource
    end
    
    authorize! action_name.to_sym, object
  end
end