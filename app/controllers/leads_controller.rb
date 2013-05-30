class LeadsController < ApplicationController

  def create
    @lead = Lead.new
    @lead.email = params[:email]
    @lead.save
    redirect_to root_path
  end

end