module Id
  module Form
    class FieldWithFormSupport < Id::Model::Field

      def additional_method_definers
        [ Id::Model::Definer::FieldFormField ]
      end

    end
  end
end

