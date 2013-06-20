class FieldForm

  def self.define(field)
    field.model.form_object.instance_eval do
      define_method field.name do
        memoize field.name do
          Option[model.send(field.name)].flatten.value_or nil if model.data.has_key? field.key
        end
      end
      attr_writer field.name
    end
  end

end
