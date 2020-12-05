module GraphqlPaginator
  module Types
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    module ClassMethods
      @@consts = {}

      def paginated(type, options = nil)
        unless type.ancestors.include?(GraphQL::Schema::Object)
          raise ArgumentError,
                "type argument must be a class inherited from GraphQL::Schema::Object class"
        end

        options ||= default_options
        define_pagination_type(type.to_s, options)
      end

      private

      def define_pagination_type(base_type, options)
        pagination_type = pagination_type_const(base_type)
        
        if @@consts[pagination_type]
          @@consts[pagination_type]
        else
          @@consts[pagination_type] = create_graphql_const(
            base_type,
            pagination_type,
            options
          )
        end
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
          name: :collection,
          null: false,
          paginated_name: :pagination
        }
      end
    end
  end
end
