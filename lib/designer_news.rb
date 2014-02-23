require "designer_news/version"
require "designer_news/client"
require "designer_news/mixins/configurable"
require "designer_news/default_options"

module DesignerNews
  class << self
    include DesignerNews::Configurable

    def client
      @client ||= DesignerNews::Client.new(options)
    end
  end
end

DesignerNews.setup