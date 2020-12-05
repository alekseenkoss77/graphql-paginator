# frozen_string_literal: true

RSpec.describe GraphqlPaginator::Types do
  
  # rubocop:disable Style/ClassAndModuleChildren
  class TestGrapqhlPaginatorType < GraphQL::Schema::Object
    include GraphqlPaginator::Types
  end
  # rubocop:enable Style/ClassAndModuleChildren

  describe '.paginated' do
    it 'creates new graphql type with pagination type' do
      const = TestGrapqhlPaginatorType.paginated(TestGrapqhlPaginatorType)
      expect(const).to be
    end
  end
end
