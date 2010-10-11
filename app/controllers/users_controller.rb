class UsersController < BaseController
  def create
    create! do |success, failure|
      success.html do
        render :create
      end
      
      failure.html do
        render :new
      end
    end
  end
  
  def update
    resource.admin = params[:user][:admin] == '1' if current_user.admin?
    update!
  end

  def activate
    user = resource_class.active!(params[:perishable_token])
    UserSession.create(user)

    redirect_to current_user
  end

  protected

  def collection
    @users ||= User.active.all
  end
  
  def authorize_resource!
    if action_name == 'activate'
      can? :activate, resource_class
    else
      super
    end
  end
end
