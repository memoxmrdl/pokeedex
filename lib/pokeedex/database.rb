# frozen_string_literal: true

require 'sequel'

Sequel.extension :migration

module Pokeedex # :nodoc:
  ##
  # Class that holds the database connection and methods to connect to the database and run the migrations if needed and clean the database for testing purposes
  class Database
    ##
    # The database connection to use for the gem (default: /path/to/pokeedex/db/pokeedex_local.sqlite3)
    attr_accessor :db_connection

    ##
    # Connect to the database with the configuration provided and set the database connection to the connection object
    def self.connect(config)
      @db_connection = config.db_connection
    end

    ##
    # Return the database connection to use for the gem (default: /path/to/pokeedex/db/pokeedex_local.sqlite3)
    def self.connection
      @db_connection
    end

    ##
    # Run the migrations for the database connection to the database file to use for the gem (default: /path/to/pokeedex/db/pokeedex_local.sqlite3) using the migrations in the migrations folder
    # The migrations are run in the order of the timestamp in the filename of the migration file (e.g. 001_create_pokemon_table.rb)
    def self.run_migrations!
      Sequel::Migrator.run(connection, File.join(Pokeedex.root_path, 'lib', 'pokeedex', 'db', 'migrations'))
    end

    ##
    # Clean the database by deleting all the rows in all the tables in the database for testing purposes (e.g. before running the tests)
    def self.clean!
      connection.tables.each do |table|
        connection.from(table).delete
      end
    end
  end
end
