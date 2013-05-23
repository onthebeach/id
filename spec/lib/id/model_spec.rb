require 'spec_helper'

class NestedModel
  include Id::Model
  field :yak
end

class CompboundElementModel
  include Id::Model
  field :plugh
  field :thud
end

class TestModel
  include Id::Model

  field :foo
  field :bar, key: 'baz'
  field :qux, optional: true
  field :quux, default: false
  field :date_of_birth, optional: true, type: Date
  field :empty_date, optional: true, type: Date
  field :christmas, default: Date.new(2014,12,25), type: Date
  field :quxx, optional: true

  compound_field :corge, {plugh: 'foo', thud: 'quux'}, type: CompboundElementModel

  has_one :aliased_model, type: NestedModel
  has_one :nested_model, key: 'aliased_model'
  has_one :extra_nested_model
  has_one :test_model
  has_many :nested_models

  class ExtraNestedModel
    include Id::Model
    field :cats
  end
end

describe Id::Model do
  let (:model) { TestModel.new(foo: 3,
                               baz: 6,
                               quxx: 8,
                               test_model: {},
                               date_of_birth: '06-06-1983',
                               aliased_model: { 'yak' => 11},
                               nested_models: [{ 'yak' => 11}, { yak: 14 }],
                               extra_nested_model: { cats: "MIAOW" }) }


  describe ".new" do
    it 'converts any passed id models to their hash representations' do
      new_model = TestModel.new(test_model: model)
      new_model.test_model.data.should eq model.data
    end
  end

  describe ".field" do
    it 'defines an accessor on the model' do
      model.foo.should eq 3
    end

    it 'allows key aliases' do
      model.bar.should eq 6
    end

    it 'allows default values' do
      model.quux.should be_false
    end

    describe "optional flag" do
      context 'when field is not in hash' do
        it 'is None' do
          expect(model.qux).to eq None
        end

      end
      context 'when field is in hash' do
        it 'is Some' do
          expect(model.quxx).to eq Some[8]
        end

      end
    end

    describe "typecast option" do
      it 'typecasts to the provided type if a cast exists' do
        model.date_of_birth.should be_some Date
        model.christmas.should be_a Date
      end

      it 'should work for empty optional fields' do
        model.empty_date.should be_none
      end
    end

  end

  describe ".compound_field" do
    it 'defines an accessor on the model' do
      model.corge.should be_a CompboundElementModel
    end

    it 'deals with default values' do
      model.corge.thud.should be_false
    end
  end

  describe ".has_one" do
    it "allows nested models" do
      model.aliased_model.should be_a NestedModel
    end
    it "allows nested models" do
      model.nested_model.should be_a NestedModel
      model.nested_model.yak.should eq 11
    end
    it "allows associations to be nested within the class" do
      model.extra_nested_model.should be_a TestModel::ExtraNestedModel
      model.extra_nested_model.cats.should eq 'MIAOW'
    end
    it "allows recursively defined models" do
      model.test_model.should be_a TestModel
    end
  end

  describe ".has_many" do
    it 'creates an array of nested models' do
      model.nested_models.should be_a Array
      model.nested_models.first.should be_a NestedModel
      model.nested_models.first.yak.should eq 11
      model.nested_models.last.yak.should eq 14
    end
  end

  describe "#set" do
    it "creates a new model with the provided values changed" do
      model.set(foo: 999).should be_a TestModel
      model.set(foo: 999).foo.should eq 999
    end
  end

  describe "#unset" do
    it 'returns a new basket minus the passed key' do
      expect { model.set(foo: 999, bar: 555).unset(:foo, :bar).foo }.to raise_error Id::MissingAttributeError, "foo"
    end

    it 'does not error if the key to be removed does not exist' do
      expect { model.unset(:not_in_hash) }.to_not raise_error
    end
  end

  describe "#fields are present methods" do
    it 'allows you to check if fields are present' do
      model = TestModel.new(foo: 1)
      model.foo?.should be_true
      model.bar?.should be_false
    end
  end

  describe "#==" do
    it 'is equal to another id model with the same data' do
      one = TestModel.new(foo: 1)
      two = TestModel.new(foo: 1)
      one.should eq two
    end

    it 'is not equal to two models with different data' do
      one = TestModel.new(foo: 1)
      two = TestModel.new(foo: 2)
      one.should_not eq two
    end
  end

  describe "#hash" do
    it 'allows id models to be used as hash keys' do
      one = TestModel.new(foo: 1)
      two = TestModel.new(foo: 1)
      hash = { one => :found }
      hash[two].should eq :found
    end
    it 'they are different keys if the data is different' do
      one = TestModel.new(foo: 1)
      two = TestModel.new(foo: 2)
      hash = { one => :found }
      hash[two].should be_nil
      hash[one].should eq :found
    end
  end

  describe ".to_proc" do
    it 'allows eta expansion of the class name to its constructor' do
      [{foo: 1}].map(&TestModel).first.should be_a TestModel
      [{foo: 1}].map(&TestModel).first.foo.should eq 1
    end
  end
end
