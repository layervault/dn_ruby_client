require 'hashie'

module DesignerNews
  class Model < Hashie::Mash
    class << self
      def build_associations(hash, *associations)
        mapping = {}

        associations.each do |association|
          mapping[association] = hash.fetch(association.to_s, {})
          hash.delete(association) if mapping[association]
        end

        instance = new(hash)

        associations.each do |association|
          klass = association_to_class(association)
          objs = mapping[association].map { |p| klass.new(p) }
          instance[association.to_s] = objs
        end

        instance
      end

      private

      def association_to_class(association)
        class_name = association.to_s.chomp('s').capitalize
        DesignerNews.const_get(class_name)
      end
    end

    def set_context(context_arguments={})
      self.context = {}
      context_arguments.each do |argument, value|
        self.context[argument] = value
      end
      self
    end
  end
end
