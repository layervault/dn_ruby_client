module DesignerNews
  class Client
    module Comments
      def comment(comment_id)
        get "comments/#{comment_id}"
      end

      def upvote_comment(comment_id)
        post "comments/#{comment_id}/upvote"
      end

      def reply_to_comment(comment_id, comment)
        post "comments/#{comment_id}/reply", { comment: { body: comment } }
      end
    end
  end
end