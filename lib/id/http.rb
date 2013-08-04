module Id

  module Http

    def self.included(base)
      base.extend(API)
    end

    module API

      def resource(name, url)
        define_singleton_method name do |query|
          new GET.new(url, query).result
        end
      end

      def resources(name, url)
        define_singleton_method name do |query|
          GET.new(url, query).result.map(&self)
        end
      end
    end

  end
end
