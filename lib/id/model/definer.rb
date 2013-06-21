module Id
  module Model
    module Definer

      def make(model, name, &block)
        model.instance_eval do
          define_method name do
            memoize(name, &block)
          end
        end
      end

      class FieldGetter
        extend Definer

        def self.define(field)
          make field.model, field.name do |data|
            field.value_of(data)
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
