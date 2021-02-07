# frozen_string_literal: true

module GraphqlPaginator
  module Adapters
    module Kaminari
      def paginated_collection(entries, options)
        options ||= {}
        entries.page(options[:page]).per(options[:per_page])
      end

      def paginate_collection(entries, options = nil)
        raise ArugmentError, 'entries argument must be Enumerable' if entries.is_a?

        collection_name = options[:name] || GraphqlPaginator.config[:collection_name]
        pagination_name = options[:pagination] || GraphqlPaginator.config[:pagination_name]

        paginated = paginated_collection(entries, options)

        {
          collection_name => paginated,
          pagination_name => populate_pagination(paginated)
        }
      end

      def populate_pagination(paginated)
        {
          total_count: paginated.total_count,
          per_page: paginated.per_page,
          total_pages: paginated.total_pages,
          page: paginated.page
        }
      end
    end
  end
end
