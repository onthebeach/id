require 'spec_helper'

module Id
  describe Model do
    let(:tested_model) { Class.new do include Id::Model; end }

    describe "#fetch_field" do
      context "when field doesn't exists" do
        it "raises Id::MissingAttributeError" do
          expect{ tested_model.new({}).fetch_field(:foo) }.to raise_error Id::MissingAttributeError
        end
      end
    end
  end
end
