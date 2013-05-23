require 'spec_helper'

class Gerbil
  include Id::Model

  field :name
  field :paws

  form do
    validates_presence_of :name
    validates_length_of :name, maximum: 4
  end

end

module Id
  module Model
    describe Form do

      let (:gerbil) { Gerbil.new(name: 'Berty') }
      let (:form)   { gerbil.to_model }

      subject { gerbil.to_model }

      it_behaves_like "ActiveModel"

      it 'has the same fields as the model' do
        form.name.should eq 'Berty'
      end

      it 'works with active model validations' do
        form.should_not be_valid
        form.name = 'Bert'
        form.should be_valid
      end
    end
  end
end
