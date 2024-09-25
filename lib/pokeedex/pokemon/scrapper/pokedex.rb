# frozen_string_literal: true

require_relative 'base'

module Pokeedex # :nodoc:
  module Pokemon # :nodoc:
    module Scrapper # :nodoc:
      ##
      # The Pokedex scrapper. It holds the methods to crawl the Pokedex data from the Pokemon website
      class Pokedex < Base
        ##
        # Find by number or name the Pokemon data from the Pokemon website
        attr_reader :number_or_name

        def initialize(number_or_name:)
          @number_or_name = number_or_name
        end

        ##
        # Return the URL to crawl the Pokemon data
        # If you number_or_name is 'pikachu' then the URL will be 'https://www.pokemon.com/el/pokedex/pikachu'
        # @return [String]
        def url
          "#{BASE_URI}/#{number_or_name}"
        end

        ##
        # Crawl the Pokemon data from the Pokemon website
        # @return [Hash]
        def crawl
          parser.as_json
        end

        private

        def parser
          Parsers::Base.new(remote_content)
        end

        def remote_content
          fetcher.content
        end

        def fetcher
          @fetcher ||= Fetchers::Base.new(url: url)
        end
      end
    end
  end
end
