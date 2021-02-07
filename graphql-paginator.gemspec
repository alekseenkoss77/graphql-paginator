# frozen_string_literal: true

require_relative 'lib/graphql_paginator/version'

Gem::Specification.new do |spec|
  spec.name          = 'graphql-paginator'
  spec.version       = GraphqlPaginator::VERSION
  spec.authors       = ['Sergei Alekseenko']
  spec.email         = ['alekseenkoss@gmail.com']

  spec.summary       = 'This Gem provides offset based pagination for graphql-ruby'
  spec.description   = 'This Gem provides offset based pagination for graphql-ruby'
  spec.homepage      = 'https://github.com/alekseenkoss77/graphql-paginator'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = 'https://github.com/alekseenkoss77/graphql-paginator'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/alekseenkoss77/graphql-paginator'
  spec.metadata['changelog_uri'] = 'https://github.com/alekseenkoss77/graphql-paginator/tree/master/changelog.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'graphql'
  spec.add_runtime_dependency 'zeitwerk'

  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rubocop'
end
