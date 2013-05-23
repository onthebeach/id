module Id
  module Model
    class Form
      include ActiveModel::Validations
      include ActiveModel::Conversion
      extend  ActiveModel::Naming

      def initialize(model)
        @model = model
      end

      def persisted?
        false
      end

      private

      attr_reader :model
    end
  end
end
