module Id
  module Model
    class CompoundField < Association

      def initialize(model, name, fields, options)
        @fields = fields
        super(model, name, options)
      end

      def definers
        [
          Definer::CompoundFieldGetter,
          Definer::FieldSetter,
          Definer::FieldIsPresent,
          Definer::FieldFormField
        ]
      end

      attr_accessor :fields
    end
  end
end
