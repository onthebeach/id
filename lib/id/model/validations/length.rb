module Id
  module Model
    module Validations
      class Length

        def initialize(field, constraints)
          @field = field
          @constraints = constraints
        end

        def errors(model)
          model.send("#{field}_as_option").map do |value|
            constraints.flat_map do |constraint, bound|
              if constraint == :minimum && value.length < bound
                ["Field '#{field}' has length smaller than the minimum of #{bound}"]
              elsif constraint == :maximum && value.length > bound
                ["Field '#{field}' has length greater than the maximum of #{bound}"]
              else
                []
              end
            end
          end.value_or ["Field '#{field}', with length restriction, is not set"]
        end

        private

        attr_reader :field, :constraints
      end
    end

    module Validator

      def validates_length_of field, constraints
        validations << Validations::Length.new(field, constraints)
      end
    end
  end
end
