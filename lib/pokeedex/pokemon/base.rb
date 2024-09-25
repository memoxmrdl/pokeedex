# frozen_string_literal: true

module Pokeedex
  module Pokemon
    class Base
      def self.search(query)
        Searcher::Base.new(query)
      end
    end
  end
end
