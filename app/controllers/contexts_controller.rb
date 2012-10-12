class ContextsController < ApplicationController

  def new
    @context = Context.new
    respond_with(@context)
  end

  def show
    @context = Context.find(params[:id])
    respond_with(@context) do |format|
      format.html { render "layers/explore", :layout => "explore" }
    end
  end

  def create
    @context = Context.new(params[:context])
    @context.save
    respond_with(@context)
  end

  def update
    @context = Context.find(params[:id])
    @context.update_attributes(params[:context])
    respond_with(@context)
  end
end