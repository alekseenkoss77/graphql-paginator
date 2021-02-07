# frozen_string_literal: true

require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.setup

module GraphqlPaginator
  def self.configure
    yield(config)
  end

  def self.config
    @config ||= Config.new
  end
end
