module Id
  module Model
    attr_reader :data

    def initialize(data = {})
      @data = Hashifier.hashify(data)
    end

    def set(values)
      self.class.new(data.merge(Hashifier.hashify(values)))
    end

    def unset(*keys)
      self.class.new(data.except(*keys.map(&:to_s)))
    end

    def eql? other
      other.is_a?(Id::Model) && other.data.eql?(self.data)
    end
    alias_method :==, :eql?

    def hash
      data.hash
    end

    private

    def self.included(base)
      base.extend(Descriptor)
    end

    def memoize(f, &b)
      instance_variable_get("@#{f}") || instance_variable_set("@#{f}", b.call(data))
    end

  end
end
