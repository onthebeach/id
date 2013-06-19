module Id
  module Model
    class Field

      def initialize(model, name, options)
        @model = model
        @name = name
        @options = options
      end

      def definers
        [
          Definer::FieldSetter,
          Definer::FieldIsPresent,
          Definer::FieldFormField
        ]
      end

      def define
        definers.each { |definer| definer.define(self) }
        hook_define(self)
      end

      def hook_define(field)
        Definer::FieldGetter.define(field)
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
          elsif !optional? then raise MissingAttributeError, key end
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

      def hook_define(field)
        Definer::FieldOptionGetter.define(field)
      end
    end
  end
end
