# frozen_string_literal: true

module GraphqlPaginator
  class PaginationType < GraphQL::Schema::Object
    field :total_count, Integer, 'Total count of items', null: false
    field :per_page, Integer, 'Number of items visible on a page', null: false
    field :total_pages, Integer, 'Total count of pages', null: true
    field :page, Integer, 'Current page number', null: false
  end
end
