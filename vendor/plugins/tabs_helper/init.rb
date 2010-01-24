# Include hook code here

ActionController::Base.send :include, TabsHelper
ActionView::Base.send :include, TabsHelper::Helpers::ViewHelpers
