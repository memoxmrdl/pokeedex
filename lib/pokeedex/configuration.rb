# frozen_string_literal: true

require "sequel"

module Pokeedex
  class Configuration
    attr_accessor :playwright_cli_executable_path

    attr_reader :db_name

    attr_writer :db_path

    def initialize
      @playwright_cli_executable_path = File.join(Dir.pwd, "node_modules", ".bin", "playwright")

      @db_name = "pokeedex_local.sqlite3"
    end

    def db_name=(name)
      @db_name = name
      @db_path = nil
    end

    def db_path
      @db_path ||= File.join(Pokeedex.root_path, "pokeedex", "db", db_name)
    end

    def db_connection
      Sequel.sqlite(db_path)
    end
  end
end
