module Id
  module Model
    class Definer

      def self.method(context, name, &value_block)
        me = self
        context.instance_eval do
          define_method name do
            memoize(me.mem_name(name.to_s), &value_block)
          end
        end
      end

      def self.mem_name(name)
        name.end_with?("?") ? name.gsub("?", "_zyzzyballubah") : name
      end
    end
  end
end
