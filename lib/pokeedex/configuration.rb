# frozen_string_literal: true

require 'sequel'

module Pokeedex # :nodoc:
  ##
  # Class that holds the configuration of the gem and the database connection information
  # and methods to connect to the database and run the migrations if needed
  class Configuration
    ##
    # The name of the database file to use for the gem (default: pokeedex_local.sqlite3)
    attr_reader :db_name

    ##
    # The path to the database file to use for the gem (default: /path/to/pokeedex/db/pokeedex_local.sqlite3)
    attr_writer :db_path

    def initialize
      @db_name = 'pokeedex_local.sqlite3'
    end

    ##
    # Set the name of the database file to use for the gem and reset the path to the database file to nil
    def db_name=(name)
      @db_name = name
      @db_path = nil
    end

    ##
    # Return the path to the database file to use for the gem (default: /path/to/pokeedex/db/pokeedex_local.sqlite3)
    def db_path
      @db_path ||= File.join(Pokeedex.root_path, 'lib', 'pokeedex', 'db', db_name)
    end

    ##
    # Return the database connection to the database file to use for the gem (default: /path/to/pokeedex/db/pokeedex_local.sqlite3)
    def db_connection
      Sequel.sqlite(db_path)
    end
  end
end
