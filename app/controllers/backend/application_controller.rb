require "application_responder"

class Backend::ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html
  layout "backend"

  before_filter :require_login
  before_filter :require_account!
  
  protect_from_forgery

  private
  def not_authenticated
    redirect_to login_url, :alert => "First log in to view this page."
  end

  def require_account!
    @current_account = Account.find_by_subdomain!(request.subdomain)
  end
end
