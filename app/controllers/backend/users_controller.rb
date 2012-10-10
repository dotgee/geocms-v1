class Backend::UsersController < Backend::ApplicationController

  def index
    @users = User.all
    respond_with([:backend, @users])
  end

end
