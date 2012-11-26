class UsersController < ApplicationController
  layout "home"
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to "/accounts/new"
    else
      render :new
    end
  end
end
