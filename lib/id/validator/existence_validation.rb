module Id
  module Validator
    class ExistenceValidation
      attr_reader :field

      def initialize(field)
        @field = field
      end

      def valid?(model)
        model.fetch_field(field.to_s, false) && true
      end

      def error_message
        "#{field} doesn't exist"
      end

    end
  end
end
