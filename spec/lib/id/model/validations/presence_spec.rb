require 'spec_helper'

module Id
  module Model
    module Validations
      describe Presence do

        let (:test_class) { Class.new {
          include Id::Model

          field :foo
          field :bar

          validates_presence_of :foo, :bar
        }}

        let (:model) { test_class.new }

        it 'validates presence of the passed fields' do
          model.should_not be_valid
        end

        it 'adds an error message for each invalid field' do
          model.errors.should eq [
            "Required field 'foo' is not set",
            "Required field 'bar' is not set"
          ]
        end

        it 'is valid if all required fields are set' do
          model.set(foo: 1, bar: 2).should be_valid
        end

        it 'creates no errors if all required fields are set' do
          model.set(foo: 1, bar: 2).errors.should be_empty
        end
      end
    end
  end
end
