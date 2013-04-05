module Id
  module Validator
    class TypeValidation
      attr_reader :field

      def initialize(field, type)
        @field = field
        @type = type
      end

      def valid?(model)
        model.fetch_field(field.to_s, nil).is_a? type
      end

      def error_message
        "#{field} is not type #{type}"
      end

      private
      attr_reader :type

    end

  end
end
