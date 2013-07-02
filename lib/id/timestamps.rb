module Id
  module Timestamps

    def self.included(base)
      base.field :created_at
      base.field :updated_at
    end

    def initialize(data = {})
      super data.merge(_timestamps data)
    end

    private

    def _timestamps(data, now=Time.now)
      {
        :created_at => data.fetch('created_at', now),
        :updated_at => now
      }
    end

  end
end
