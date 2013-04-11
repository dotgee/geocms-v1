class ContextPreviewWorker
  include Sidekiq::Worker
  include Rails.application.routes.url_helpers

  def perform(context, url)

    t = Tempfile.new([context["uuid"], ".png"])
    t.binmode
    #TODO
    #catch errors
    `phantomjs #{Rails.root}/script/thumbnail.js #{url_for_context(context, url)} #{t.path}` 
    t.rewind
    ctx = Context.find(context["id"])
    ctx.preview = t
    ctx.save 
  end
  
  private
    def url_for_context(context, url)
      #mettre en place une configuration d'url
      return url + share_context_path({ id: context["uuid"] })
    end
end
