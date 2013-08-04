module Id
  module Http
    class UrlPattern
      def initialize(url, query)
        @url   = url
        @query = query
      end

      def substitute
        query.reduce(url) { |acc, (k, v)| acc.gsub(":#{k}", v.to_s) }
      end

      private

      attr_reader :url, :query
    end
  end
end
