module Id
  module Model
    class HasMany < Association

      def definers
        [
          Definer::HasManyGetter,
          Definer::FieldSetter,
          Definer::FieldIsPresent,
          Definer::FieldFormField
        ]
      end

    end
  end
end
