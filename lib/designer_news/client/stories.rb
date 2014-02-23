module DesignerNews
  class Client
    module Stories
      def recent_stories(page=1)
        get "stories/recent", { page: page }
      end

      def search_stories(query)
        get "stories/search", { query: query }
      end

      def story(story_id)
        get "stories/#{story_id}"
      end

      def upvote_story(story_id)
        post "stories/#{story_id}/upvote"
      end

      def reply_to_story(story_id, comment)
        post "stories/#{story_id}/reply", { comment: { body: comment } }
      end

      def stories(page=1)
        get "stories", { page: page }
      end
    end
  end
end