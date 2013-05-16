module Id
  module Validator
    class Size < Presence
      def initialize(field, constraints)
        @field = field
        @constraints = constraints
      end

      private

      def errors(model)
        super.tap do |errors|
        end
      end

      def min
        constraints.fetch(:minimum, false)
      end

      def max
        constraints.fetch(:maximum, false)
      end
    end
  end
end
