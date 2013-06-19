module Id
  module Model
    class HasOne < Association

      def hook_define(field)
        Definer::HasOneGetter.define(field)
      end

    end

    class HasOneOption < Association

      def hook_define(field)
        Definer::HasOneOptionGetter.define(field)
      end

    end
  end
end
