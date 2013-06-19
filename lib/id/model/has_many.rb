module Id
  module Model
    class HasMany < Association

      def hook_define
        Definer::HasManyGetter.define(self)
      end

    end
  end
end
