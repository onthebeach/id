module Id
  module Model
    class HasOne < Association

      def definer
        optional ? Definer::HasOneOptionGetter : Definer::HasOneGetter
      end

    end
  end
end
