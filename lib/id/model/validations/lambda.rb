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

        def block
          @block.is_a?(Symbol) ? ->(model){ model.send(@block) } : @block
        end

        attr_reader :options
      end
    end

    module Validator

      def validates(block, options={})
        validations << Validations::Lambda.new(block, options)
      end

    end
  end
end
