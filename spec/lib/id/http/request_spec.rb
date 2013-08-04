require 'spec_helper'

module Id
  module Http
    describe Request do

      let (:request) { Request.new      }
      let (:http)    { stub(env: env) }
      let (:env)     { { body: body, status: status, response_headers: headers } }

      let (:body)    { stub }
      let (:status)  { stub }
      let (:headers) { stub }

      before { request.stub(:request).and_return(http) }

      it 'can return the response body' do
        expect(request.response.body).to eq body
      end

      it 'can return the response status' do
        expect(request.response.status).to eq status
      end

      it 'can return the response headers' do
        expect(request.response.headers).to eq headers
      end

    end
  end
end
