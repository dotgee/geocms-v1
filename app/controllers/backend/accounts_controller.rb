class Backend::AccountsController < Backend::ApplicationController
  def index
    @accounts = Account.all
  end

  def new
    @account = Account.new
    user = @account.users.build
    respond_with [:backend, @account]
  end

  def create
    @account = Account.new(params[:account])
    @account.save
    respond_with [:backend, :accounts]
  end
end
