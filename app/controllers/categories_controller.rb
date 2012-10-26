class CategoriesController < ApplicationController
  def index
    #@categories = Category.includes(:layers).roots
    #respond_with(@categories)
    respond_to do |format|
      format.json { render json: Oj.dump(Category.json_tree(Category.arrange_nodes(Category.with_layers))) }
    end
  end

  def show
    @category = Category.find_by_slug(params[:id])
    respond_with(@category) do |format|
      format.html { render :partial => @category}
    end
  end
end