module Id
  module Model
    class Field

      def initialize(model, name, options)
        @model = model
        @name = name
        @options = options
      end

      def define_getter
        field = self
        model.send :define_method, name do
          memoize field.name do
            field.cast data.fetch(field.key, &field.default_value)
          end
        end
      end

      def define_setter
        model.send(:builder_class).define_setter name
      end

      def define_is_present
        field = self
        model.send :define_method, "#{name}?" do
          data.has_key?(field.key) && !data.fetch(field.key).nil?
        end
      end

      def define
        define_getter
        define_setter
        define_is_present
      end

      def cast(value)
        TypeCasts.cast(options.fetch(:type, false), value)
      end

      def key
        options.fetch(:key, name).to_s
      end

      def default_value
        proc do
          if default? then default
          elsif !optional? then raise MissingAttributeError end
        end
      end

      def default?
        options.has_key?(:default)
      end

      def default
        options.fetch(:default)
      end

      def optional?
        options.fetch(:optional, false)
      end

      attr_reader :model, :name, :options
    end

    class FieldOption < Field
      def define_getter
        field = self
        model.send :define_method, name do
          memoize field.name do
            if d = data.fetch(field.key, &field.default_value)
              Some[field.cast d]
            else
              None
            end
          end
        end
      end
    end
  end
end
