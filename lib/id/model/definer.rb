module Id
  module Model
    module Definer

      class FieldGetter

        def self.define(model, name, &value_block)
          model.instance_eval do
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
              data.has_key?(field.key) && !data.fetch(field.key).nil?
            end
          end
        end
      end
    end
  end
end
