# frozen_string_literal: true

module GraphqlPaginator
  class Registry
    @@types = {}

    def self.exists?(type)
      !!get(type)
    end

    def self.get(key)
      @@types[key]
    end

    def self.add(key, type)
      @@types[key] = type
    end

    def self.all
      @@types
    end

    def self.clean!
      @@types = {}
    end
  end
end
