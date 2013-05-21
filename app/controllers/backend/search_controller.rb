class Backend::SearchController < Backend::ApplicationController

  def search
    @layers = Layer.search(params)
  end

end
