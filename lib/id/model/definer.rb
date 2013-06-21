module Id
  module Model
    module Definer

      class FieldGetter

        def self.define(field)
          field.model.instance_eval do
            define_method field.name do
              memoize field.name do |data|
                field.value_of(data)
              end
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
