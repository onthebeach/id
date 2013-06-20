module Id
  module Model
    class HasMany < Association

      def definer
        Definer::HasManyGetter
      end

    end
  end
end
