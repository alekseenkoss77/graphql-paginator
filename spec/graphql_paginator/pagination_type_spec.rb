# frozen_string_literal: true

RSpec.describe GraphqlPaginator::Types do
  class TestType < GraphQL::Schema::Object
    include GraphqlPaginator::Types
  end

  describe '.paginated' do
    let(:registry) { GraphqlPaginator::Registry }

    after { registry.clean! }

    it 'creates new graphql type with pagination type and default fields' do
      const = TestType.paginated(TestType)
      expect(const).to be
      expect(const.graphql_name).to eq('TestPaginatedType')
      expect(const.own_fields.keys).to include('collection')
      expect(const.own_fields.keys).to include('pagination')
    end

    it 'uses Registry class to store pagination const' do
      TestType.paginated(TestType)
      expect(registry.exists?('TestPaginatedType')).to eq(true)
    end

    it 'registers paginated type only one time' do
      3.times { TestType.paginated(TestType) }
      expect(registry.all.count).to eq(1)
    end

    context 'with custom options' do
      it 'creates pagination type with user defined fields' do
        const = TestType.paginated(TestType, name: :entries, paginated_name: :page_data)

        expect(const.own_fields.keys).to_not include('collection')
        expect(const.own_fields.keys).to_not include('pagination')

        expect(const.own_fields.keys).to include('entries')
        expect(const.own_fields.keys).to include('pageData')
      end
    end

    context 'with custom configuration' do
      before do
        GraphqlPaginator.configure do |c|
          c.collection_name = 'custom_collection'
          c.pagination_name = 'custom_pagination'
        end
      end

      it 'creates pagination type with configuration details' do
        const = TestType.paginated(TestType)
        expect(const.own_fields.keys).to include('customCollection')
        expect(const.own_fields.keys).to include('customPagination')
      end
    end
  end
end
