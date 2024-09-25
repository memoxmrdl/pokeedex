# frozen_string_literal: true

require_relative 'fetchers/base'
require_relative 'parsers/base'

module Pokeedex # :nodoc:
  module Pokemon # :nodoc:
    module Scrapper # :nodoc:
      ##
      # Base class for the Pokemon scrapper. It holds the methods to crawl the Pokemon data from the Pokemon website
      class Base
        ##
        # The base URI to crawl the Pokemon data
        BASE_URI = 'https://www.pokemon.com/el/pokedex'

        ##
        # Crawl the Pokemon data from the Pokemon website
        def crawl
          raise NotImplementedError
        end

        private

        def parser
          raise NotImplementedError
        end

        def fetcher
          raise NotImplementedError
        end
      end
    end
  end
end
