class LayersController < ApplicationController

  def index
    @layers = @current_account.layers.for_frontend
    respond_with @layers
  end

  def show
    @layer = @current_account.layers.find(params[:id])
    respond_with(@layer)
  end
end
