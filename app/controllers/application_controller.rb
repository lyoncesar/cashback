class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :authenticate_user!
  layout :layout_by_resource

  def layout_by_resource
    return "devise" if devise_controller?

    "application"
  end

  def admin_user?
    current_user.admin?
  end
end
