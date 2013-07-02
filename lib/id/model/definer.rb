module Id
  module Model
    class Definer

      def self.method_memoize(context, name, &value_block)
        method(context, name) do |object|
          object.instance_eval do
            memoize(name, &value_block)
          end
        end
      end

      def self.method(context, name, &value_block)
        context.instance_eval do
          define_method name do
            value_block.call(self)
          end
        end
      end

    end
  end
end
