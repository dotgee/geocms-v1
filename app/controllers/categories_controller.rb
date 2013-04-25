class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:layers).all
    #respond_with(@categories)
    respond_to do |format|
      format.json { render json: Oj.dump(Category.json_tree(Category.arrange_nodes(Category.ordered))) }
    end
  end

  def show
    @category = Category.find_by_slug(params[:id])
    @category ||= Category.find_by_id(params[:id])
    @context = Context.new
    render "contexts/show"
  end

  def layers
    @category = Category.find_by_slug(params[:category_id])
    @layers = @category.layers.includes(:data_source).includes(:dimensions)
    render "layers/index"
  end
end
