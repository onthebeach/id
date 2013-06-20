module Id
  module Model
    class HasOne < Association

      def method_getter
        optional ? Definer::HasOneOptionGetter : Definer::HasOneGetter
      end

    end
  end
end
