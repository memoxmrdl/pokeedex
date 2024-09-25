# frozen_string_literal: true

require_relative "base"

module Pokeedex
  module Pokemon
    module Scrapper
      class Pokedex < Base
        attr_reader :number_or_name

        def initialize(number_or_name:)
          @number_or_name = number_or_name
        end

        def url
          "#{BASE_URI}/#{number_or_name}"
        end

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
