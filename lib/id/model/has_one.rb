module Id
  module Model
    class HasOne < Association

      def hook_define
        Definer::HasOneGetter.define(self)
      end

    end

    class HasOneOption < Association

      def hook_define
        Definer::HasOneOptionGetter.define(self)
      end

    end
  end
end
