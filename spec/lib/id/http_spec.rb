require 'spec_helper'
require 'support/test_model_with_api'
require 'support/request_stubs'

module Id
  describe Http do

    let (:trevor)  { TestModelWithApi.new(id: 4, name: 'Trevor') }
    let (:trevor1) { TestModelWithApi.new(id: 4, name: 'Trevor Wright') }
    let (:trevor2) { TestModelWithApi.new(id: 5, name: 'Trevor McDonald') }

    before do
      stub_request(:get, "http://test-model-api/4").to_return(RequestStubs.trevor)
      stub_request(:get, "http://test-model-api/name/Trevor").to_return(RequestStubs.trevors)
    end

    describe '#resource' do
      it 'defines a method that returns a singular resource as a model' do
        expect(TestModelWithApi.find(id: 4)).to eq trevor
      end
    end

    describe '#resources' do
      it 'defines a method that returns an array of resources as models' do
        expect(TestModelWithApi.for_name(name: 'Trevor')).to eq [trevor1, trevor2]
      end
    end

  end
end
