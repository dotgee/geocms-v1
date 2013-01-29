class Backend::DataSourcesController < Backend::ApplicationController
  def index
    @data_sources = DataSource.all
    respond_with([:backend, @data_sources])
  end

  def show
    @data_source = DataSource.find(params[:id])
    respond_with([:backend, @data_source])
  end

  def new
    @data_source = DataSource.new
    respond_with([:backend, @data_source])
  end

  def edit
    @data_source = DataSource.find(params[:id])
  end

  def create
    @data_source = DataSource.new(params[:data_source])
    @data_source.save
    respond_with([:backend, @data_source])
  end

  def update
    @data_source = DataSource.find(params[:id])
    @data_source.update_attributes(params[:data_source])
    respond_with([:backend, @data_source])
  end

  def destroy
    @data_source = DataSource.find(params[:id])
    @data_source.destroy
    respond_with([:backend, @data_source])
  end

  def import
    @data_source = DataSource.find(params[:id])
    @layers = @data_source.import
    #gon.categories = Category.for_select.map { |c| { val: c.id, label: c.depth_name } } 
    gon.categories = Category.leafs.map { |c| { val: c.id, label: c.depth_name } } 
    gon.rabl "app/views/layers/index.json.rabl", :as => :layers
    respond_with([:backend, @data_source])
  end
end
