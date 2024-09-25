# frozen_string_literal: true

module Pokeedex # :nodoc:
  module Pokemon # :nodoc:
    ##
    # The base class for the Pokemon module. It holds the methods to search for a Pokemon by number or name
    class Base
      ##
      # Search for a Pokemon by number or name
      # @param query [String] the number or name of the Pokemon to search
      def self.search(query)
        Searcher::Base.new(query)
      end
    end
  end
end
