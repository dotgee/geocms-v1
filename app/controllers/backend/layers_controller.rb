class Backend::LayersController < Backend::ApplicationController
  # GET /layers
  # GET /layers.json
  def index
    @layers = Layer.all

    respond_with([:backend, @layers])
  end

  def explore
    render :layout =>  "explore"
  end 
  # GET /layers/1
  # GET /layers/1.json
  def show
    @layer = Layer.find(params[:id])

    respond_with([:backend, @layer])
  end

  # GET /layers/new
  # GET /layers/new.json
  def new
    @layer = Layer.new
    @categories = Category.order(:names_depth_cache).map { |c| ["- " * c.depth + c.name,c.id] }
    respond_with([:backend, @layer])
  end

  # GET /layers/1/edit
  def edit
    @layer = Layer.find(params[:id])
    @categories = Category.order(:names_depth_cache).map { |c| ["- " * c.depth + c.name,c.id] }
    respond_with([:backend, @layer])
  end

  # POST /layers
  # POST /layers.json
  def create
    @layer = Layer.new(params[:layer])
    @layer.save
    respond_with([:backend, @layer])
  end

  # PUT /layers/1
  # PUT /layers/1.json
  def update
    @layer = Layer.find(params[:id])
    @layer.update_attributes(params[:layer])
    respond_with [:backend, @layer]
  end

  # DELETE /layers/1
  # DELETE /layers/1.json
  def destroy
    @layer = Layer.find(params[:id])
    @layer.destroy

    respond_with([:backend, @layer])
  end
end
