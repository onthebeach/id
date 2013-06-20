module Id
  module Form

    def as_form
      @form_object ||= self.class.form_object.new(self)
    end

    def errors
      as_form.errors
    end

    def valid?
      as_form.valid?
    end

    def self.included(base)
      base.extend(Descriptor)
    end

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
          instance_exec do
            define_singleton_method :model_name do
              ActiveModel::Name.new(self, nil, base.name)
            end
          end
        end
      end

      class FieldWithFormSupport < Id::Model::Field

        def additional_method_definers
          [ Id::Model::Definer::FieldFormField ]
        end

      end
    end
  end
end
