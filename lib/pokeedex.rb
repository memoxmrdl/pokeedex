# frozen_string_literal: true

require 'base64'

require_relative 'pokeedex/exceptions'
require_relative 'pokeedex/version'
require_relative 'pokeedex/configuration'
require_relative 'pokeedex/database'
require_relative 'pokeedex/pokemon/decorators/base'
require_relative 'pokeedex/pokemon/scrapper/pokedex'
require_relative 'pokeedex/pokemon/searcher/base'
require_relative 'pokeedex/pokemon/base'

module Pokeedex # :nodoc:
  ##
  # The root path of the gem
  @root_path = File.expand_path(File.join(__dir__))

  class << self
    ##
    # Return the root path of the gem
    #
    # === Example
    #  > Pokeedex.root_path
    #  > "/path/to/pokeedex"
    attr_reader :root_path
  end

  ##
  # The configuration of the gem
  def self.configuration
    @configuration ||= Configuration.new
  end

  ##
  # Configure the gem with a block of configuration
  def self.configure
    yield(configuration)
  end

  ##
  # Connect to the database and run the migrations
  def self.connect_to_database
    Database.connect(configuration)
    Database.run_migrations!

    require_relative 'pokeedex/pokemon/model/base'
  end

  ##
  # Boot the gem by connecting to the database and running the migrations if needed and loading the models
  def self.boot
    connect_to_database
  end
end
