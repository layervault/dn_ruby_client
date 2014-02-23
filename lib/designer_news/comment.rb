module DesignerNews
  class Comment < DesignerNews::Model
    class << self
      def find(comment_id)
        resp = MultiJson.decode(LayerVault.client.comment(comment_id))
        instance = new(resp)
      end
    end
  end
end