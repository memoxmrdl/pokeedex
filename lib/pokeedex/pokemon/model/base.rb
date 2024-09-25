# frozen_string_literal: true

require "sequel"
require "json"

require_relative "../../database"

module Pokeedex
  module Pokemon
    module Model
      class Base < Sequel::Model(Database.connection[:pokemons])
        plugin :timestamps, update_on_create: true
        plugin :validation_helpers
        plugin :serialization, :json, :abilities, :gender, :types, :weakness, :stats

        def self.search(query)
          where(Sequel.|({number: query}, Sequel.ilike(:name, query)))
        end

        def validate
          super
          validates_presence %i[number name]
          validates_unique :number
        end

        def persisted?
          !id.nil?
        end
      end
    end
  end
end
