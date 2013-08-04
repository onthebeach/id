module Id
  module Http
    class GET < Request

      def initialize(url, query = {})
        @url   = url
        @query = query
      end

      def result
        parsed_response if response.status == 200 or raise APIError
      end

      private

      attr_reader :url, :query

      def query_url
        UrlPattern.new(url, query).substitute
      end

      def parsed_response
        Yajl::Parser.parse(response.body)
      end

      def request
        @request ||= Faraday.get("http://#{query_url}")
      end

    end
  end
end
