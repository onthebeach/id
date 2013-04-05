module Id
  module Validator
    class SizeValidation
      attr_reader :field

      def initialize(field, size)
        @field = field
        @size = size
      end

      def valid?(model)
        f = model.fetch_field(field.to_s, "")
        f.is_a?(Numeric) || f.size < size
      end

      def error_message
        "#{field} size is greater then #{size}"
      end

      private
      attr_reader :size

    end
  end
end