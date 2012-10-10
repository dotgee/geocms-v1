class HomeController < ApplicationController
  def index
    @account = Account.new
  end
end
