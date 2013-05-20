module Id
  module Model
    module Validations

      class Lambda
        def initialize(block, options)
          @block = block
          @options = options
        end

        def errors(model)
          block.call(model) ? [] : [options.fetch(:message, "Custom validation failed")]
        end

        private

        attr_reader :block, :options
      end
    end

    module Validator

      def validates(block, options={})
        validations << Validations::Lambda.new(block, options)
      end

    end
  end
end
