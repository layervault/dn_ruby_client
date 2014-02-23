module DesignerNews
  class Client
    module Users
      def me
        get "me"
      end
    end
  end
end