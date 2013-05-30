class HomeController < ApplicationController
  def index
    #@account = Account.new
    @lead = Lead.new
  end
end
