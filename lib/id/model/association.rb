module Id
  module Model
    class Association < Field

      def type
        options.fetch(:type) { inferred_class }
      end

      def inferred_class
        hierarchy.parent.const_get(inferred_class_name)
      end

      def inferred_class_name
        @inferred_class_name ||= name.to_s.classify
      end

      def hierarchy
        @hierarchy ||= Hierarchy.new(model.name, inferred_class_name)
      end

      class Hierarchy

        def initialize(path, child)
          @path = path
          @child = child
        end

        def parent
          @parent ||= constants.find do |c|
            c.ancestors.find { |anc| anc.const_defined? child }
          end
        end

        def constants
          hierarchy.map(&:constantize)
        end

        private

        def hierarchy(name=path)
          name.match /(.*)::.*$/
          $1 ? [name] + hierarchy($1) : [name]
        end

        attr_reader :path, :child
      end
    end
  end
end
