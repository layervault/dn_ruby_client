module DesignerNews
  module Configurable
    attr_accessor :access_token, :user_agent, :middleware
    attr_writer :api_endpoint

    class << self
      def keys
        @keys ||= [
          :access_token,
          :api_endpoint,
          :user_agent,
          :middleware
        ]
      end
    end

    def configure
      yield self
    end

    def reset!
      DesignerNews::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", DesignerNews::Default.options[key])
      end
      self
    end

    alias setup reset!

    def api_endpoint
      ::File.join(@api_endpoint, "")
    end

    private

    def options
      Hash[DesignerNews::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end
  end
end
