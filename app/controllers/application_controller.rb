require "application_responder"

class ApplicationController < ActionController::Base
  include UrlHelper

  self.responder = ApplicationResponder
  respond_to :html, :json
  protect_from_forgery

  set_current_tenant_by_subdomain(:account, :subdomain)
  before_filter :load_account
  
  private
    def load_account
      @current_account = ActsAsTenant.current_tenant
    end
end
