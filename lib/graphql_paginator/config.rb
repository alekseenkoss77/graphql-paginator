module GraphqlPaginator
  attr_accessor :provider, :collection_name, :pagination_name

  def initialize
    @provider = pagination_provider
    @collection_name = 'collection'
    @pagination_name = 'pagination'
  end

  private
  
  def pagination_provider
    return :will_paginate if defined?(WillPaginate)
    return :kaminari if defined?(Kaminari)

    :custom
  end
end
