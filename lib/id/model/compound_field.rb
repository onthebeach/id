module Id
  module Model
    class CompoundField < Association

      def initialize(model, name, fields, options)
        @fields = fields
        super(model, name, options)
      end

      def hook_define
        Definer::CompoundFieldGetter.define(self)
      end

      attr_accessor :fields
    end
  end
end
