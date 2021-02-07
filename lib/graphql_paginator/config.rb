# frozen_string_literal: true

module GraphqlPaginator
  class Config
    attr_accessor :provider, :collection_name, :pagination_name, :nullify

    def initialize
      @provider = pagination_provider
      @collection_name = 'collection'
      @pagination_name = 'pagination'
      @nullify = true
    end

    private

    def pagination_provider
      return :will_paginate if defined?(WillPaginate)
      return :kaminari if defined?(Kaminari)

      :custom
    end
  end
end
