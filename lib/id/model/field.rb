module Id
  module Model
    class Field

      def initialize(model, name, options)
        @model = model
        @name = name
        @options = options
      end

      def define
        define_getter(self)
        define_setter
        define_is_present(self)
        define_form_field(self)
      end

      def define_getter(field)
        make_getter field do |data|
          field.cast data.fetch(field.key, &field.default_value)
        end
      end

      def define_setter
        model.send(:builder_class).define_setter name
      end

      def define_is_present(field)
        model.send(:define_method, "#{name}?") do
          data.has_key?(field.key) && !data.fetch(field.key).nil?
        end
      end

      def define_form_field(field)
        model.form_object.send :define_method, name do
          memoize field.name do
            Option[model.send(field.name)].flatten.value_or nil if model.data.has_key? field.key
          end
        end
        model.form_object.send :attr_writer, name
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

      def make_getter(field, &block)
        model.instance_eval do
          define_method field.name do
            memoize(field.name, &block)
          end
        end
      end
    end

    class FieldOption < Field
      def define_getter(field)
        make_getter(field) do |data|
          Option[data.fetch(field.key, &field.default_value)].map do |d|
            field.cast d
          end
        end
      end
    end
  end
end
