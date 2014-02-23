require 'faraday'
require 'multi_json'
require 'json'

require 'designer_news/mixins/authentication'
require 'designer_news/mixins/configurable'
require 'designer_news/mixins/connection'

require 'designer_news/client/users'
require 'designer_news/client/stories'
require 'designer_news/client/comments'

require 'designer_news/model'
require 'designer_news/user'
require 'designer_news/story'
require 'designer_news/comment'

module DesignerNews

  class ClientParamsError < Exception ; end

  class Client
    include DesignerNews::Authentication
    include DesignerNews::Configurable
    include DesignerNews::Connection

    include DesignerNews::Client::Users
    include DesignerNews::Client::Stories
    include DesignerNews::Client::Comments

    def initialize(options={})
      DesignerNews::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || DesignerNews.instance_variable_get(:"@#{key}"))
      end
    end

    def get(url, options = {})
      request :get, url, options
    end

    def post(url, options = {})
      request :post, url, options
    end

    def put(url, options = {})
      request :put, url, options
    end

    def delete(url, options = {})
      request :delete, url, options
    end

  end
end