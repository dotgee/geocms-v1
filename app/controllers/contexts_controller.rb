class ContextsController < ApplicationController
  layout "explore", :except => :index
  before_filter :send_layers_to_front, :only => [:new, :show, :share]

  def index
    @contexts = Context.all
    respond_with(@contexts)
  end

  def new
    @context = Context.new
    respond_with(@context) do |format|
      format.html { render "show" }
    end
  end

  def show
    @context = Context.includes(:layers).find_by_uuid(params[:id])
    respond_with(@context)
  end

  def share
    @context = Context.includes(:layers).find_by_uuid(params[:id])
    respond_with(@context) do |format|
      format.html { render :layout => "explore" }
    end
  end

  def create
    @context = Context.new(params[:context])
    @context.save
    respond_with(@context)
  end

  def update
    @context = Context.find_by_uuid(params[:id])
    @context.update_attributes(params[:context])
    respond_with(@context)
  end

  private
    def send_layers_to_front
      @layers = @current_account.layers.includes(:dimensions).for_frontend
      gon.rabl "app/views/layers/index.json.rabl", :as => :layers
    end
end