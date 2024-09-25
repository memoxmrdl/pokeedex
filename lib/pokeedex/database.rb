# frozen_string_literal: true

require "sequel"

Sequel.extension :migration

module Pokeedex
  class Database
    attr_accessor :db_connection

    def self.connect(config)
      @db_connection = config.db_connection
    end

    def self.connection
      @db_connection
    end

    def self.run_migrations!
      Sequel::Migrator.run(connection, File.join(Pokeedex.root_path, "pokeedex", "db", "migrations"))
    end

    def self.clean!
      connection.tables.each do |table|
        connection.from(table).delete
      end
    end
  end
end
