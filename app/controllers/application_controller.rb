require "application_responder"

class ApplicationController < ActionController::Base
  include UrlHelper

  self.responder = ApplicationResponder
  respond_to :html, :json, :xml
  protect_from_forgery

  set_current_tenant_by_subdomain(:account, :subdomain)
  before_filter :load_account
  
  private
    def load_account
      @current_account = ActsAsTenant.current_tenant
    end
    
    def not_authenticated
      redirect_to login_url, :alert => "First log in to view this page."
    end
end
