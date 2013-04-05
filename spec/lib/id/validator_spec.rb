require 'spec_helper'

class ValidatedModel
  include Id::Model
  include Id::Validator

  validates_existence_of :foo
  validates_type_of :foo, String
  validates_size_of :foo, 10
  field :foo
end

class ModelWithHash
  include Id::Model
  include Id::Validator

  validates_type_of :foo, :bar, Hash
  field :foo
  field :bar
end

module Id
  describe Validator do
    describe "#valid?" do
      it "checks if the model is valid?" do
        expect(ValidatedModel.new(foo: "bar", bar: "bar", baz: "baz").valid?).to be_true
        expect(ValidatedModel.new(foo: "barasdfasdfasdfasdf", bar: "bar", baz: "baz").valid?).to be_false
      end
    end

    describe ".validates_existence_of" do
      it "checks wheter the certain method is defined" do
        expect(ValidatedModel.new({}).valid?).to be_false
      end

    end

    describe ".validates_type_of" do
      it "checks if field has correct type" do
        expect(ValidatedModel.new(foo: "bar").valid?).to be_true
        expect(ModelWithHash.new(foo: {}, bar: {}).valid?).to be_true
        expect(ModelWithHash.new(foo: "bar").valid?).to be_false
        expect(ValidatedModel.new(foo: 1).valid?).to be_false
      end
    end

    describe "#validation_errors" do
      it "returns an array of validation errors" do
        expect(ValidatedModel.new({}).validation_errors).to be_a Array
        expect(ValidatedModel.new({}).validation_errors).not_to be_empty
        expect(ValidatedModel.new({}).validation_errors.size).to eq(3)
      end
      it "returns an array with objects that has error_message in it" do
        expect(ValidatedModel.new({}).validation_errors.map(&:error_message)).to be_a Array
      end
    end
  end
end

