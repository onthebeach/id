module Id
  module Model
    module Definer

      class FieldGetter

        def self.define(context, name, &value_block)
          context.instance_eval do
            define_method name do
              memoize(name, &value_block)
            end
          end
        end
      end

      class FieldIsPresent

        def self.define(field)
          field.model.instance_eval do
            define_method "#{field.name}?" do
              field.presence_of(data)
            end
          end
        end
      end
    end
  end
end
