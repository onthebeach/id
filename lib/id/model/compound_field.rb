module Id
  module Model
    class CompoundField < Association

      def initialize(model, name, fields, options)
        @fields = fields
        super(model, name, options)
      end

      def method_getter
        Definer::CompoundFieldGetter
      end

      attr_accessor :fields
    end
  end
end
