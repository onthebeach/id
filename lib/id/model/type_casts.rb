module Id
  module Model
    module TypeCasts

      def self.cast(type, value)
        casts.fetch(type, Identity).new(value).cast
      end

      protected

      def self.register(cast)
        casts[cast.type] = cast
      end

      private

      def self.casts
        @casts ||= {}
      end

      class Cast

        def initialize(value)
          @value = value
        end

        def cast
          value.is_a?(type) ? value : conversion
        end

        def type
          self.class.type
        end

        def conversion
          raise NotImplementedError
        end

        private

        def self.type
          raise NotImplementedError
        end

        attr_reader :value

      end

      class Identity < Cast
        def cast
          value
        end
      end

      class Date < Cast

        def self.type
          ::Date
        end

        def conversion
          ::Date.parse value
        end

        TypeCasts.register(self)
      end

      class Time < Cast

        def self.type
          ::Time
        end

        def conversion
          ::Time.parse value
        end

        TypeCasts.register(self)
      end

      class Money < Cast

        def self.type
          ::Money
        end

        def conversion
          ::Money.new value.to_i
        end

        TypeCasts.register(self)
      end

    end
  end
end
