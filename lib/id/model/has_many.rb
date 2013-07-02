module Id
  module Model
    class HasMany < Association

      def value_of(data)
        data.fetch(key, []).map { |r| type.new(r) }
      end

    end
  end
end
