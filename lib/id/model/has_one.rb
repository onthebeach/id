module Id
  module Model
    class HasOne < Association

      def definers
        [
          Definer::HasOneGetter,
          Definer::FieldSetter,
          Definer::FieldIsPresent,
          Definer::FieldFormField
        ]
      end

    end

    class HasOneOption < Association

      def definers
        [
          Definer::HasOneOptionGetter,
          Definer::FieldSetter,
          Definer::FieldIsPresent,
          Definer::FieldFormField
        ]
      end
    end
  end
end
