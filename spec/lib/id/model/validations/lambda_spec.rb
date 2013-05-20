require 'spec_helper'

module Id
  module Model
    module Validations
      describe Lambda do

        let (:test_class) { Class.new {
          include Id::Model

          field :foo
          field :bar

          validates ->(m){ m.foo == 4 }, message: 'foo must be 4'

        }}

        let (:model) { test_class.new }

        it 'is not valid if the block returns false' do
          model.set(foo: 2).should_not be_valid
          model.set(foo: 2).errors.should eq ["foo must be 4"]
        end

        it 'is valid if the block returns true' do
          model.set(foo: 4).should be_valid
        end

      end
    end
  end
end
