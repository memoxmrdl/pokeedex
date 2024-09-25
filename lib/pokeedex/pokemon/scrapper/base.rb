# frozen_string_literal: true

require_relative "fetchers/base"
require_relative "parsers/base"

module Pokeedex
  module Pokemon
    module Scrapper
      class Base
        BASE_URI = "https://www.pokemon.com/el/pokedex"

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
