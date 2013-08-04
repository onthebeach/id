module Id
  module Http
    class Request

      def response
        @response ||= Response.new(request)
      end

    end
  end
end
