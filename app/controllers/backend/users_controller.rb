class Backend::UsersController < Backend::ApplicationController
  def index
    @users = User.all
    respond_with([:backend, @users])
  end

  def new
    @user = User.new
    respond_with [:backend, @user]
  end

  def create
    @user = User.new(params[:user])
    @user.save
    respond_with [:backend, :users]
  end
end
