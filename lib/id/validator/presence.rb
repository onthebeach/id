module Id

  module Validator
    class Presence

      def initialize(fields)
        @fields = fields
      end

      def errors(model)
        fields.select { |field| !model.send("#{field}?") }.map do |field|
          "#{field} is not present"
        end
      end

      private

      attr_reader :fields
    end
  end

  module Validations
    def validates_presence_of(*fields)
      validations << Validator::Presence.new(fields)
    end
  end

end
