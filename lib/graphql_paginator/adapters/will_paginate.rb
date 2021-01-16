module GraphqlPaginator
  module Adapters
    module WillPaginate
      def paginated_collection(entries, options)
        options ||= {}
        entries.page(options[:page]).per_page(options[:per_page])
      end

      def populate_pagination(paginated)
        {
          total_count: paginated.total_entries,
          per_page: paginated.per_page,
          total_pages: paginated.total_pages,
          page: paginated.current_age
        }
      end
    end
  end
end
