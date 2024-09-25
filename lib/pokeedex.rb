# frozen_string_literal: true

require "base64"

require_relative "pokeedex/exceptions"
require_relative "pokeedex/version"
require_relative "pokeedex/configuration"
require_relative "pokeedex/database"
require_relative "pokeedex/pokemon/decorators/base"
require_relative "pokeedex/pokemon/scrapper/pokedex"
require_relative "pokeedex/pokemon/searcher/base"
require_relative "pokeedex/pokemon/base"

module Pokeedex
  @root_path = File.expand_path(File.join(__dir__))

  class << self
    attr_accessor :configuration

    attr_reader :root_path
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.connect_to_database
    Database.connect(configuration)
    Database.run_migrations!

    require_relative "pokeedex/pokemon/model/base"
  end

  def self.boot
    connect_to_database
  end
end
