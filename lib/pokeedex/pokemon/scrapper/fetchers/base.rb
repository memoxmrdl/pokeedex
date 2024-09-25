# frozen_string_literal: true

require 'playwright'

module Pokeedex # :nodoc:
  module Pokemon # :nodoc:
    module Scrapper # :nodoc:
      module Fetchers # :nodoc:
        ##
        # It holds the Playwright instance and the methods to fetch the content of a URL
        # and fake mouse movements and scroll the page to avoid detection, and to generate a random viewport size to avoid detection.
        # This implementation is based on the Playwright gem (
        class Base
          ##
          # The URL to fetch the content from
          attr_reader :url

          ##
          # The Playwright executable instance to use
          attr_reader :playwright_exec

          ##
          # The Playwright instance to use to interact with the browser and the page to fetch the content from the URL
          attr_reader :playwright

          def initialize(url:)
            @url = url
            @playwright_exec = Playwright.create(playwright_cli_executable_path: Pokeedex.configuration.playwright_cli_executable_path)
            @playwright = playwright_exec.playwright
          end

          ##
          # Fetch the content of the URL and return the content as a string (HTML) or raise an exception if the content could not be fetched
          def content
            browser do |context|
              page = context.new_page(viewport: generate_random_viewport)
              page.goto(url)
              page.wait_for_load_state

              fake_mouse_movements(page, steps: 6)
              fake_scroll_page_down_and_up(page)

              page.content
            end
          rescue Playwright::Error
            raise Exceptions::ScrapperError
          end

          ##
          # Open a browser instance and execute the block with the browser instance and close the browser instance after the block is executed
          def browser(&block)
            block.call(chromium)
          ensure
            chromium.close
          end

          private

          def chromium
            @chromium ||= begin
              args = [
                '--no-sandbox',
                '--disable-setuid-sandbox',
                '--disable-blink-features=AutomationControlled'
              ]

              playwright.chromium.launch(headless: true, args: args)
            end
          end

          def generate_random_viewport
            min_width = 1024
            max_width = 2560
            min_height = 800
            max_height = 1440

            width = rand(min_width..max_width)
            height = rand(min_height..max_height)

            { width: width, height: height }
          end

          def fake_mouse_movements(page, steps: 5)
            viewport = page.viewport_size

            max_width = viewport[:width]
            max_height = viewport[:height]

            steps.times do
              x = rand(0..max_width)
              y = rand(0..max_height)

              page.mouse.move(x, y)

              sleep(rand(0.2..0.5))
            end
          end

          def fake_scroll_page_down_and_up(page)
            page_height = page.evaluate('document.body.scrollHeight')

            current_scroll_position = 0
            scroll_step = 100

            while current_scroll_position < page_height
              page.evaluate("window.scrollBy(0, #{scroll_step})")
              current_scroll_position += scroll_step

              sleep(0.01)
            end

            while current_scroll_position > 0
              page.evaluate("window.scrollBy(0, -#{scroll_step})")
              current_scroll_position -= scroll_step

              sleep(0.01)
            end
          end
        end
      end
    end
  end
end
