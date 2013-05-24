require 'spec_helper'

class Gerbil
  include Id::Model

  field :name
  field :paws

  form do
    validates_presence_of :name
    validates_length_of :name, maximum: 4
  end

  def name_in_caps
    name.upcase
  end

end

module Id
  module Model
    describe Form do

      let (:gerbil) { Gerbil.new(name: 'Berty') }
      let (:form)   { gerbil.as_form }

      subject { gerbil.as_form }

      it_behaves_like "ActiveModel"

      it 'responds to to_model' do
        subject.to_model.should eq subject
      end

      it 'has the same fields as the model' do
        form.name.should eq 'Berty'
      end

      it 'works with active model validations' do
        form.should_not be_valid
        form.name = 'Bert'
        form.should be_valid
      end

      it 'delegates to the model' do
        form.name_in_caps.should eq 'BERTY'
      end
    end
  end
end
