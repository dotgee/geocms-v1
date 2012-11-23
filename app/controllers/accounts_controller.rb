class AccountsController < ApplicationController

  def create
    @account = Account.new(params[:account])
    if @account.save
      redirect_to root_url(:subdomain => @account.subdomain)
    else
      redirect_to root_url
    end
  end

end
