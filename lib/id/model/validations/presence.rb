module Id
  module Model
    module Validations
      class Presence

        def initialize(fields, options={})
          @fields = fields
        end

        def errors(model)
          fields.select { |f| model.send("#{f}_as_option").none? }.map do |f|
            options.fetch(:message, "Required field '#{f}' is not set")
          end
        end

        private

        attr_reader :fields
      end

    end

    module Validator
      def validates_presence_of *fields
        validations << Validations::Presence.new(fields)
      end
    end

  end
end
