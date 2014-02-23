require 'faraday'
require 'designer_news/response/error'

module DesignerNews
  module Middleware
    class RaiseError < Faraday::Response::Middleware
      private
      def on_complete(response)
        if error = DesignerNews::Response::Error.from_response(response)
          raise error
        end
      end
    end
  end
end
