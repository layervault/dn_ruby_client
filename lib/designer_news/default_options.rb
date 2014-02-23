require 'designer_news/version'
require 'designer_news/middleware/raise_error'

module DesignerNews
  module Default

    API_ENDPOINT = "https://api-news.layervault.com/api/v1/".freeze
    USER_AGENT   = "Designer News Ruby Gem #{DesignerNews::VERSION}".freeze

    MIDDLEWARE = Faraday::Builder.new do |builder|
      builder.use DesignerNews::Middleware::RaiseError
      builder.request :url_encoded
      builder.adapter Faraday.default_adapter
    end

    class << self
      def options
        Hash[DesignerNews::Configurable.keys.map{|key| [key, send(key)]}]
      end

      def access_token
        ENV['DESIGNER_NEWS_ACCESS_TOKEN']
      end

      def api_endpoint
        ENV['DESIGNER_NEWS_API_ENDPOINT'] || API_ENDPOINT
      end

      def user_agent
        ENV['DESIGNER_NEWS_USER_AGENT'] || USER_AGENT
      end

      def middleware
        MIDDLEWARE
      end
    end
  end
end