# frozen_string_literal: true

module GraphqlPaginator
  module Types
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    module ClassMethods
      def paginated(type, options = nil)
        unless type.ancestors.include?(GraphQL::Schema::Object)
          raise ArgumentError,
                'type argument must be a class inherited from GraphQL::Schema::Object class'
        end

        options = default_options.merge(options || {})
        define_pagination_type(type.to_s, options)
      end

      private

      def define_pagination_type(base_type, options)
        pagination_type = pagination_type_const(base_type)
        return registry.get(pagination_type) if registry.exists?(pagination_type)

        const = create_graphql_const(
          base_type,
          pagination_type,
          options
        )

        registry.add(pagination_type, const)
        const
      end

      def create_graphql_const(base_type, paginated_type, options)
        Class.new(GraphQL::Schema::Object) do
          graphql_name paginated_type
          field options[:name], [base_type], null: options[:null]
          field options[:paginated_name], GraphqlPaginator::PaginationType, null: true
        end
      end

      def pagination_type_const(base_type)
        klass_name = base_type.to_s.split('::').last

        if klass_name =~ /Type$/
          klass_name.gsub(/Type$/, 'PaginatedType')
        else
          "#{klass_name}PaginatedType"
        end
      end

      def default_options
        {
          name: GraphqlPaginator.config.collection_name,
          null: GraphqlPaginator.config.nullify,
          paginated_name: GraphqlPaginator.config.pagination_name
        }
      end

      def registry
        GraphqlPaginator::Registry
      end
    end
  end
end
