require 'spec_helper'

class Gerbil
  include Id::Model

  field :name
  field :paws

  form do
    validates_presence_of :name
    validates_size_of :paws, maximum: 4
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
    end
  end
end
