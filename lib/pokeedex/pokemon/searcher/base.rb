# frozen_string_literal: true

require "forwardable"

module Pokeedex
  module Pokemon
    module Searcher
      class Base
        extend Forwardable

        attr_reader :query, :records

        def initialize(query)
          @query = query
          @records = collection
        end

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
