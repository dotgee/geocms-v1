class LayersController < ApplicationController

  def index
    @layers = current_tenant.layers.for_frontend
    respond_with @layers
  end

  def search
    @layers = Layer.search(params)
    respond_with @layers
  end

  def show
    @layer = current_tenant.layers.find(params[:id])
    respond_with(@layer)
  end
end
