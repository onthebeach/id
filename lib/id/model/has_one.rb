module Id
  module Model
    class HasOne < Association

      def value_of(data)
        if optional?
          child = data.fetch(key, nil)
          child.nil? ? None : Some[type.new(child)]
        else
          child = data.fetch(key) { raise MissingAttributeError, key }
          type.new(child) unless child.nil?
        end
      end

    end
  end
end
