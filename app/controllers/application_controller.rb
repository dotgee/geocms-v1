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

    def current_ability
      @current_ability ||= Ability.new(current_user, current_tenant)
    end

    rescue_from CanCan::AccessDenied do |exception|
      Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
      #redirect_to root_url, :alert => t("access_denied")
    end
end
