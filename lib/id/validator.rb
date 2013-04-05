module Id
  module Validator

    def valid?
      validation_errors.empty?
    end

    def validation_errors
      self.class.validations.select { |validation| !validation.valid?(self) }
    end

    private

    def self.included(base)
      base.extend(Descriptor)
    end

    module Descriptor
      def validations
        @validations ||= []
      end

      def validates_existence_of(*fields)
        fields.each do |field|
          validations << ExistenceValidation.new(field)
        end
      end

      def validates_type_of(*fields, type)
        fields.each do |field|
          validations << TypeValidation.new(field, type)
        end
      end

      def validates_size_of(*fields, size)
        fields.each do |field|
          validations << SizeValidation.new(field, size)
        end
      end
    end
  end
end
