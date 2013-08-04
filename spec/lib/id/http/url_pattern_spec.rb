require 'spec_helper'

module Id
  module Http
    describe UrlPattern do
      it 'replaces any :keys in the pattern with their corresponding value' do
        url, query = 'domain.com/:id', { id: 4 }
        pattern = UrlPattern.new(url, query)
        expect(pattern.substitute).to eq 'domain.com/4'
      end
    end
  end
end
