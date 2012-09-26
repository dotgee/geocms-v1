class LayersController < ApplicationController
  # GET /layers
  # GET /layers.json
  def index
    @layers = Layer.all
    respond_with(@layers)
  end

  def explore
    @layers = Layer.all
    render :layout =>  "explore"
  end 
  # GET /layers/1
  # GET /layers/1.json
  def show
    @layer = Layer.find(params[:id])

    respond_with(@layer)
  end
end
