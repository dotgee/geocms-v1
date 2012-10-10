class AccountsController < ApplicationController

  def create
    @account = Account.new(params[:account])
    @account.save
    redirect_to root_url(:subdomain => @account.subdomain)
  end

end