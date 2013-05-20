require 'spec_helper'

module Id
  module Model
    module Validations
      describe Length do

        let (:test_class) { Class.new {
          include Id::Model

          field :foo
          field :bar
          field :baz

          validates_length_of :foo, minimum: 5
          validates_length_of :bar, maximum: 5, message: 'bar must be shorter than 5'
          validates_length_of :baz, minimum: 3, maximum: 5
        }}

        let (:model) { test_class.new }

        it 'is not valid if the field is not set' do
          model.should_not be_valid
        end

        it 'is not valid if the field is smaller than the minimum' do
          model.set(foo: 'ak').errors.should include "Field 'foo' has length smaller than the minimum of 5"
        end

        it 'is not valid if the field is greater than the maximum' do
          model.set(bar: 'catatat').errors.should include "bar must be shorter than 5"
        end

        it 'is valid if all the length constraints are met' do
          model.set(foo: 'abcde', bar: 'abc', baz: 'abcd').should be_valid
        end

      end
    end
  end
end
