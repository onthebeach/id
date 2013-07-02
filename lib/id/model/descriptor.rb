module Id
  module Model
    module Descriptor

      def field(f, options={})
        Field.new(self, f, options).define
      end

      def has_one(f, options={})
        HasOne.new(self, f, options).define
      end

      def has_many(f, options={})
        HasMany.new(self, f, options).define
      end

      def to_proc
        lambda { |data| new data }
      end

    end
  end
end
