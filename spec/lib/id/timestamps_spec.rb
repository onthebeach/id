require 'spec_helper'

class TimeStampedModel
  include Id::Model
  include Id::Timestamps

  field :foo
  field :bar
end

module Id
  describe Timestamps do

    let(:model) { TimeStampedModel.new(foo: 999, bar: 666) }

    it 'should have a created_at date' do
      model.created_at.should be_a Time
    end

    it 'should update the updated at when set is called' do
      updated = model.set(foo: 123)
      expect(updated.created_at).to be < updated.updated_at
    end

    it 'should update the updated at when unset is called' do
      updated = model.unset(:foo)
      expect(updated.created_at).to be < updated.updated_at
    end

  end
end
