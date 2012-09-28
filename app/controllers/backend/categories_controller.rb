class Backend::CategoriesController < Backend::ApplicationController
  def index
    @categories = @current_account.categories.all
    respond_with([:backend, @categories])
  end

  def show
    @category = @current_account.categories.find(params[:id])
    respond_with([:backend, @category])
  end

  def new
    @category = @current_account.categories.new
    @categories = @current_account.categories.order(:names_depth_cache).map { |c| ["-" * c.depth + c.name,c.id] }
    respond_with([:backend, @category])
  end

  def edit
    @category = @current_account.categories.find(params[:id])
    @categories = @current_account.categories.order(:names_depth_cache).map { |c| ["-" * c.depth + c.name,c.id] }
  end

  def create
    @category = @current_account.categories.new(params[:category])
    @category.save
    respond_with([:backend, @category])
  end

  def update
    @category = @current_account.categories.find(params[:id])
    @category.update_attributes(params[:category])
    respond_with([:backend, @category])
  end

  def destroy
    @category = @current_account.categories.find(params[:id])
    @category.destroy
    respond_with([:backend, @category])
  end
end
