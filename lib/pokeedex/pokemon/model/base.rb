# frozen_string_literal: true

require 'sequel'
require 'json'

require_relative '../../database'

module Pokeedex # :nodoc:
  module Pokemon # :nodoc:
    module Model # :nodoc:
      ##
      # Base class for the Pokemon model. It holds the database connection and the methods to interact with the database table for the Pokemon model
      class Base < Sequel::Model(Database.connection[:pokemons])
        plugin :timestamps, update_on_create: true
        plugin :validation_helpers
        plugin :serialization, :json, :abilities, :gender, :types, :weakness, :stats

        ##
        # Search for a Pokemon by number or name
        def self.search(query)
          where(Sequel.|({ number: query }, Sequel.ilike(:name, query)))
        end

        ##
        # Validate the Pokemon model attributes
        def validate
          super
          validates_presence %i[number name]
          validates_unique :number
        end

        ##
        # Return true when the Pokemon model is persisted in the database
        def persisted?
          !id.nil?
        end
      end
    end
  end
end
