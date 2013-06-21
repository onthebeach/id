module Id
  module Model
    class HasOne < Association

      def method_getter
        optional ? Definer::HasOneOptionGetter : Definer::HasOneGetter
      end

      def value_of(data)
        child = data.fetch(key) { raise MissingAttributeError, key }
        type.new(child) unless child.nil?
      end
    end
  end
end
