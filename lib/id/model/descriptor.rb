module Id
  module Model
    module Descriptor

      def field(f, options={})
        Field.new(self, f, options).define
      end

      def has_one(f, options={})
        HasOne.new(self, f, options).define
      end

      def has_many(f, options={})
        HasMany.new(self, f, options).define
      end

      def compound_field(f, fields, options={})
        CompoundField.new(self, f, fields, options).define
      end

      def form &block
        form_object.send :instance_exec, &block
      end

      def form_object
        base = self
        @form_object ||= Class.new(Form) do
          instance_exec do
            define_singleton_method :model_name do
              ActiveModel::Name.new(self, nil, base.name)
            end
          end
        end
      end

      def to_proc
        ->(data) { new data }
      end

    end
  end
end
