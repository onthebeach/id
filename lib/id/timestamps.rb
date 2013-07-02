module Id
  module Timestamps
    def self.included(base)
      base.field :created_at
      base.field :updated_at
    end

    def initialize(data = {})
      super data.merge(:created_at => data.fetch('created_at', Time.now))
    end

    def set(values)
      self.class.new(super.data.merge(:updated_at => Time.now))
    end

    def unset(*keys)
      self.class.new(super.data.merge(:updated_at => Time.now))
    end
  end
end
