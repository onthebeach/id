require 'spec_helper'

module Id
  module Model
    module Validations
      describe Date do

        let (:test_class) { Class.new {
          include Id::Model

          field :foo
          field :bar

          validates_date :foo, past: true
          validates_date :bar, future: true, message: 'bar must be in the future'
        }}

        let (:model) { test_class.new }

        it 'is invalid if the field is not set' do
          model.should_not be_valid
        end

        it 'can validate that dates are in the past' do
          model.set(foo: 1.day.from_now).errors.should include "Field 'foo' is in the future"
        end

        it 'can validate that dates are in the future' do
          model.set(bar: 1.day.ago).errors.should include "bar must be in the future"
        end

        it 'is valid if all dates obey constraints' do
          model.set(foo: 1.hour.ago, bar: 1.hour.from_now).should be_valid
        end
      end
    end
  end
end
