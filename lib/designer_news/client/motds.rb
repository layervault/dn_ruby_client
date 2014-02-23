module DesignerNews
  class Client
    module Motds
      def motd
        get "motd"
      end

      def upvote_motd
        post "motd/upvote"
      end

      def downvote_motd
        post "motd/downvote"
      end
    end
  end
end