module DesignerNews
  class Story < DesignerNews::Model
    class << self
      def find(story_id)
        resp = MultiJson.decode(LayerVault.client.story(story_id))
        instance = new(resp)
      end
    end
  end
end