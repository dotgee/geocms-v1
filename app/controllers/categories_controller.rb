class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    respond_with([:backend, @categories])
  end

  def show
    @category = Category.find(params[:id])
    respond_with([:backend, @category])
  end
end