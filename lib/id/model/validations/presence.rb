module Id
  module Model
    module Validations
      class Presence

        def initialize(field, options)
          @field = field
          @options = options
        end

        def errors(model)
          if model.send("#{field}_as_option").none?
            [options.fetch(:message, "Required field '#{field}' is not set")]
          else
            []
          end
        end

        private

        attr_reader :field, :options
      end

    end

    module Validator
      def validates_presence_of(field, options = {})
        validations << Validations::Presence.new(field, options)
      end
    end

  end
end
