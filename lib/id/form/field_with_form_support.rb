module Id
  module Form
    class FieldWithFormSupport < Id::Model::Field

      def hook_define
        FieldForm.define(self)
      end

    end
  end
end

