require 'spec_helper'

module Id
  module Http
    describe Response do

      let (:request) { stub(env: env) }
      let (:env)     { { response_headers: headers, status: status, body: body } }

      let (:headers) { stub }
      let (:status)  { stub }
      let (:body)    { stub }

      let (:response) { Response.new(request) }

      it 'can return the status' do
        expect(response.status).to eq status
      end

      it 'can return the headers' do
        expect(response.headers).to eq headers
      end

      it 'can return the body' do
        expect(response.body).to eq body
      end
    end
  end
end
