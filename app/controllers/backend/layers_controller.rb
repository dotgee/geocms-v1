class Backend::LayersController < Backend::ApplicationController
  before_filter :require_category

  def index
    @layers = @category.layers.page params[:page]

    respond_with([:backend, @layers])
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
    respond_with([:backend, @category, @layer])
  end

  def create
    @layer = @category.layers.new(params[:layer])
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
