require 'spec_helper'

module Id
  module Http
    describe GET do

      let (:get) { GET.new('http://cats/tabby') }

      it 'returns the parsed response body if the request was successful' do
        body = '{"cat":3}'
        response = stub(env: { status: 200, body: body, response_headers: stub })
        Faraday.stub(:get).and_return(response)
        expect(get.result).to eq ({ 'cat' => 3 })
      end

      it 'raises an error if the request was not successful' do
        response = stub(env: { status: 404, body: stub, headers: stub })
        Faraday.stub(:get).and_return(response)
        expect { get.result }.to raise_error APIError
      end

    end
  end
end
