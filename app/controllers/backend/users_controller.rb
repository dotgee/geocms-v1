class Backend::UsersController < Backend::ApplicationController
  load_and_authorize_resource

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
