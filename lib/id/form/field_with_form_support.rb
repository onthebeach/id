module Id
  module Form
    class FieldWithFormSupport < Id::Model::Field

      def additional_method_definers
        [ FieldForm ]
      end

    end
  end
end

