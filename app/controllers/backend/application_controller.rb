require "application_responder"

class Backend::ApplicationController < ActionController::Base
  before_filter :set_locale
  self.responder = ApplicationResponder
  respond_to :html, :json

  layout "backend"

  protect_from_forgery

  set_current_tenant_by_subdomain(:account, :subdomain, ENV["MONO_ACCOUNT"].to_bool)
  before_filter :require_login

  private
  def not_authenticated
    redirect_to login_url, :alert => "First log in to view this page."
  end

  def set_locale
      session[:locale] = params[:locale] if params[:locale]
      session[:locale] ||= :fr
      I18n.locale = session[:locale]
  end

end
