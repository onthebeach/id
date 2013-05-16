require 'spec_helper'

module Id
  describe Validator::Presence do

    let (:test_class) {
      Class.new do
        include Id::Model

        field :cat
        field :dog

        validates_presence_of :cat, :dog
      end
    }

    describe "#validates_presence_of" do
      let (:model) { test_class.new }

      it 'should not be valid without a cat' do
        model.should_not be_valid
      end

      it 'should have a validation error for each missing key' do
        model.errors.should have(2).items
      end

      it 'should add a helpful message to the errors array' do
        model.set(dog: 3).errors.should eq ['cat is not present']
      end
    end

      end
  end
