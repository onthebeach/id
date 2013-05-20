module Id
  module Model
    module Validations
      class Length

        def initialize(field, options)
          @field = field
          @options = options
        end

        def errors(model)
          model.send("#{field}_as_option").map do |value|
            if    less_than_min? value then [minimum_error]
            elsif more_than_max? value then [maximum_error]
            else  [] end
          end.value_or ["Field '#{field}', with length restriction, is not set"]
        end

        private

        def less_than_min? value
          options[:minimum] && value.length < options[:minimum]
        end

        def more_than_max? value
          options[:maximum] && value.length > options[:maximum]
        end

        def minimum_error
          options.fetch(:message, "Field '#{field}' has length smaller than the minimum of #{options[:minimum]}")
        end

        def maximum_error
          options.fetch(:message, "Field '#{field}' has length greater than the maximum of #{options[:maximum]}")
        end

        attr_reader :field, :options
      end
    end

    module Validator

      def validates_length_of field, options
        validations << Validations::Length.new(field, options)
      end
    end
  end
end
