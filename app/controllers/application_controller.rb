require "application_responder"

class ApplicationController < ActionController::Base
  include UrlHelper

  set_current_tenant_by_subdomain(:account, :subdomain)

  self.responder = ApplicationResponder
  respond_to :html, :json, :xml
  protect_from_forgery

  private

    def not_authenticated
      redirect_to login_url, :alert => "First log in to view this page."
    end
end
