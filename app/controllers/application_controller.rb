class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :authenticate_user!

  def admin_user?
    current_user.admin?
  end
end
