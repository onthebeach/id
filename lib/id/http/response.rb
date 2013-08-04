module Id
  module Http
    class Response

      def initialize(request)
        @request = request
      end

      def body
        request.env[:body]
      end

      def status
        request.env[:status]
      end

      def headers
        request.env[:response_headers]
      end

      private

      attr_reader :request
    end
  end
end
