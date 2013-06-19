module Id
  module Model
    class HasMany < Association

      def define_getter(field)
        make_getter(field) do |data|
          data.fetch(field.key, []).map { |r| field.type.new(r) }
        end
      end

    end
  end
end
