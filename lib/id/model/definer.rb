module Id
  module Model
    module Definer

      class Maker
        def self.make(model, name, &block)
          model.instance_eval do
            define_method name do
              memoize(name, &block)
            end
          end
        end
      end

      class HasManyGetter < Maker
        def self.define(field)
          make field.model, field.name do |data|
            data.fetch(field.key, []).map { |r| field.type.new(r) }
          end
        end
      end

      class FieldOptionGetter < Maker
        def self.define(field)
          make field.model, field.name do |data|
            Option[data.fetch(field.key, &field.default_value)].map do |d|
              field.cast d
            end
          end
        end
      end

      class HasOneOptionGetter < Maker
        def self.define(field)
          make field.model, field.name do |data|
            child = data.fetch(field.key, nil)
            child.nil? ? None : Some[field.type.new(child)]
          end
        end
      end

      class HasOneGetter < Maker
        def self.define(field)
          make field.model, field.name do |data|
            child = data.fetch(field.key) { raise MissingAttributeError, field.key }
            field.type.new(child) unless child.nil?
          end
        end
      end

      class CompoundFieldGetter
        def self.define(field)
          field.model.instance_eval do
            define_method field.name do
              memoize field.name do
                compound = Hash[field.fields.map { |k,v| [k.to_s, send(v) { raise MissingAttributeError, k.to_s }]}]
                field.type.new(compound)
              end
            end
          end
        end
      end

      class FieldGetter < Maker

        def self.define(field)
          make field.model, field.name do |data|
            field.cast data.fetch(field.key, &field.default_value)
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

      class FieldFormField
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
    end
  end
end
