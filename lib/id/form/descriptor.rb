module Id
  module Form
    module Descriptor

      def field(f, options={})
        FieldWithFormSupport.new(self, f, options).define
      end

      def form &block
        form_object.send :instance_exec, &block
      end

      def form_object
        base = self
        @form_object ||= Class.new(ActiveModelForm) do
          eingenclass = class << self
            self
          end
          eingenclass.send(:define_method, :model_name) do
            ActiveModel::Name.new(self, nil, base.name)
          end
        end
      end

    end
  end
end
