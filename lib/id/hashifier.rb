module Id
  class Hashifier

    def self.hashify(data)
      new(data).hashify
    end

    def initialize(data)
      @data = data
    end

    def hashify
      Hash[data.map { |k, v| [ k.to_s, as_data(v) ] }]
    end

    private

    def as_data(v)
      case v
      when Id::Model then v.data
      when Array then v.first.is_a?(Id::Model) ? v.map(&:data) : v
      when Hash then Hashifier.hashify(v)
      else v end
    end

    attr_reader :data
  end
end
