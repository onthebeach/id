module Id
  module Model
    class HasMany < Association

      def method_getter
        Definer::HasManyGetter
      end

    end
  end
end
