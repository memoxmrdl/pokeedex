# frozen_string_literal: true

module Pokeedex
  module Exceptions
    class ScrapperError < StandardError
      def initialize(msg = "An error occurred while trying to get the information. Please try again later.")
        super
      end
    end
  end
end
