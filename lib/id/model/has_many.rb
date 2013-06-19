module Id
  module Model
    class HasMany < Association

      def hook_define(field)
        Definer::HasManyGetter.define(field)
      end

    end
  end
end
