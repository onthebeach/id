module Id
  module Model
    module Validations
      class Date

        def initialize(field, options)
          @field = field
          @options = options
        end

        def errors(model)
          model.send("#{field}_as_option").map do |value|
            if    options[:past] && value.future? then [future_error]
            elsif options[:future] && value.past? then [past_error]
            else  [] end
          end.value_or ["Field '#{field}', with date restriction, is not set"]
        end

        private

        def past_error
          options.fetch(:message, "Field '#{field}' is in the past")
        end

        def future_error
          options.fetch(:message, "Field '#{field}' is in the future")
        end

        attr_reader :field, :options

      end
    end

    module Validator

      def validates_date field, constraints
        validations << Validations::Date.new(field, constraints)
      end
    end
  end
end
