# frozen_string_literal: true

require 'playwright'

module Pokeedex
  module Pokemon
    module Scrapper
      module Fetchers
        class Base
          attr_reader :url, :playwright_exec, :playwright

          def initialize(url:)
            @url = url
            @playwright_exec = Playwright.create(playwright_cli_executable_path: Pokeedex.configuration.playwright_cli_executable_path)
            @playwright = playwright_exec.playwright
          end

          def content
            begin
              browser do |context|
                page = context.new_page(viewport: generate_random_viewport)
                page.goto(url)

                fake_mouse_movements(page, steps: 7)
                fake_scroll_page_down_and_up(page)

                page.content
              end
            rescue Playwright::Error
              raise Exceptions::ScrapperError
            end
          end

          def browser(&block)
            begin
              block.call(chromium)
            ensure
              chromium.close
            end
          end

          private

          def chromium
            @chromium ||= begin
              args = [
                '--no-sandbox',
                '--disable-setuid-sandbox',
                '--disable-blink-features=AutomationControlled'
              ]

              playwright.chromium.launch(headless: true, args:)
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
            page_height = page.evaluate("document.body.scrollHeight")

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
