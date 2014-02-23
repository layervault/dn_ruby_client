module DesignerNews
  class User < DesignerNews::Model
    class << self
      def me
        resp = MultiJson.decode(DesignerNews.client.me)
        instance
      end
    end
  end
end