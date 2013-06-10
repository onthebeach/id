module Id
  module Model
    class Form
      include ActiveModel::Validations
      include ActiveModel::Conversion
      extend  ActiveModel::Naming

      def self.i18n_scope
        :id
      end

      def initialize(model)
        @model = model
      end

      def persisted?
        false
      end

      def to_model
        self
      end

      private

      def method_missing(name, *args, &block)
        model.send(name, *args, &block)
      end

      def memoize(f, &b)
        instance_variable_get("@#{f}") || instance_variable_set("@#{f}", b.call)
      end

      attr_reader :model
    end
  end
end
