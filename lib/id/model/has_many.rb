module Id
  module Model
    class HasMany < Association

      def define_getter(field)
        model.instance_eval do
          define_method field.name do
            memoize field.name do
              data.fetch(field.key, []).map { |r| field.type.new(r) }
            end
          end
        end
      end

    end
  end
end
