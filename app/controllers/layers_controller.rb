class LayersController < ApplicationController

  def index
    @layers = current_tenant.layers.for_frontend
    respond_with @layers
  end

  def search
    @layers = Layer.search(params)
    respond_with @layers
  end

  def bbox
    layer = Layer.find(params[:id])
    bbox = layer.boundingbox(current_tenant)
    # raise layer.boundingbox(current_tenant).inspect
    respond_with bbox
  end

  def show
    @layer = current_tenant.layers.find(params[:id])
    respond_with(@layer)
  end
end
