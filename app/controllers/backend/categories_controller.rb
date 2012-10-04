class Backend::CategoriesController < Backend::ApplicationController
  def index
    @categories = Category.arrange(:order => :position)
    respond_with([:backend, @categories])
  end

  def show
    @category = Category.find(params[:id])
    respond_with([:backend, @category])
  end

  def new
    @category = Category.new
    @categories = Category.order(:names_depth_cache).map { |c| ["-" * c.depth + c.name,c.id] }
    respond_with([:backend, @category])
  end

  def edit
    @category = Category.find(params[:id])
    @categories = Category.order(:names_depth_cache).map { |c| ["-" * c.depth + c.name,c.id] }
  end

  def create
    @category = Category.new(params[:category])
    @category.save
    respond_with([:backend, @category])
  end

  def update
    @category = Category.find(params[:id])
    @category.update_attributes(params[:category])
    respond_with([:backend, @category])
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    respond_with([:backend, @category])
  end
end
