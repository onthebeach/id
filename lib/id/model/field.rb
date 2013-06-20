module Id
  module Model
    class Field

      def initialize(model, name, options)
        @model = model
        @name = name
        @options = options
      end

      def definers
        [ Definer::FieldIsPresent, Definer::FieldFormField ]
      end

      def define
        definers.each { |definer| definer.define(self) }
        hook_define
      end

      def hook_define
        definer.define(self)
      end

      def definer
        optional ? Definer::FieldOptionGetter : Definer::FieldGetter
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
