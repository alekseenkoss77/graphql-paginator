# frozen_string_literal: true

require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.setup

module GraphqlPaginator
  def self.configure
    @config ||= Config.new
    yield(configuration)
  end

  def self.config
    @config
  end
end
