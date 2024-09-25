# frozen_string_literal: true

module Pokeedex # :nodoc:
  ##
  # Class that holds the exceptions for the gem
  module Exceptions
    ##
    # Error that is raised when an error occurs while trying to get the information from the scrapper class
    class ScrapperError < StandardError
      def initialize(msg = 'An error occurred while trying to get the information. Please try again later.')
        super
      end
    end
  end
end
