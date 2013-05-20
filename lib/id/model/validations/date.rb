module Id
  module Model
    module Validations
      class Date

        def initialize(field, constraints)
          @field = field
          @constraints = constraints
        end

        def errors(model)
          model.send("#{field}_as_option").map do |value|
            if constraints[:past] && value.future?
              ["Field '#{field}' is in the future"]
            elsif constraints[:future] && value.past?
              ["Field '#{field}' is in the past"]
            else
              []
            end
          end.value_or ["Field '#{field}', with date restriction, is not set"]
        end

        private

        attr_reader :field, :constraints

      end
    end

    module Validator

      def validates_date field, constraints
        validations << Validations::Date.new(field, constraints)
      end
    end
  end
end
