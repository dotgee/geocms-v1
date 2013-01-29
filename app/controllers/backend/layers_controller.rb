class Backend::LayersController < Backend::ApplicationController
  before_filter :require_category, :except => [:create]

  def index
    redirect_to [:backend, @category]
  end

  def show
    @layer = @category.layers.find(params[:id])

    respond_with([:backend, @category, @layer])
  end

  def new
    @layer = @category.layers.new
    respond_with([:backend, @category, @layer])
  end

  def edit
    @layer = @category.layers.find(params[:id])
    @categories = Category.leafs
    respond_with([:backend, @category, @layer])
  end

  def create
    @layer = Layer.new(params[:layer].reject{ |p| p == "category_id" })
    @layer.save
    respond_with(@layer) do |format|
      format.json if request.xhr?
      format.html { redirect_to [:backend, @category] }
    end
  end

  def update
    @layer = @category.layers.find(params[:id])
    @layer.update_attributes(params[:layer])
    respond_with [:backend, @category]
  end

  def destroy
    @layer = @category.layers.find(params[:id])
    @layer.destroy

    respond_with([:backend, @category])
  end

  private
  def require_category
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
    else
      @category = Category.find(params[:layer][:category_id])
    end
  end
end
