require 'spec_helper'

class Mike
  include Id::Model

  field :cat
  field :dog, optional: true

  def catdog
    dog.value_or cat
  end

end

describe "Foobar" do
  let (:mike) { Mike.new(cat: 'pooface') }
  it 'returns cat' do
    mike.catdog.should eq 'pooface'
  end
end
