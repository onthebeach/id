module Id
  module Model
    class Field

      def initialize(model, name, options)
        @model = model
        @name = name
        @options = options
      end

      def define
        method_definers.each { |method| method.define(self) }
        hook_define
      end

      def method_definers
        [ Definer::FieldIsPresent, Definer::FieldGetter ]
      end

      def hook_define
      end

      def value_of(data)
        if optional?
          Option[data.fetch(key, &default_value)].map do |d|
            cast d
          end
        else
          cast data.fetch(key, &default_value)
        end
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
      alias_method :optional, :optional?

      attr_reader :model, :name, :options

    end
  end
end
