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

    class FieldWithFormSupport < Id::Model::Field

      def additional_method_definers
        [ Id::Model::Definer::FieldFormField ]
      end

    end
  end
end
