# frozen_string_literal: true

require 'forwardable'

module Pokeedex # :nodoc:
  module Pokemon # :nodoc:
    module Searcher # :nodoc:
      class Base # :nodoc:
        ##
        # The base class for the Pokemon searcher. It holds the methods to search the Pokemon data from the database or the Pokemon website
        extend Forwardable

        ##
        # The query to search the Pokemon data
        attr_reader :query

        ##
        # The records found from the search
        attr_reader :records

        def initialize(query)
          @query = query
          @records = collection
        end

        ##
        # Return the first record found from the search
        # @return [Pokeedex::Pokemon::Model::Base]
        def_delegators :@records, :each, :first, :last, :size, :count, :empty?

        private

        def collection
          search_or_create
        end

        def search_or_create
          result = search_from_model
          return search_and_create_from_scrapper_remote if result.empty?

          result
        end

        def search_from_model
          Pokemon::Model::Base.search(query)
        end

        def search_and_create_from_scrapper_remote
          result = Scrapper::Pokedex.new(number_or_name: query).crawl
          Pokemon::Model::Base.create(result)

          search_from_model
        rescue Sequel::ValidationFailed
          []
        end
      end
    end
  end
end
