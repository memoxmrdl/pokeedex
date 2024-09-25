# frozen_string_literal: true

require "nokogiri"

module Pokeedex
  module Pokemon
    module Scrapper
      module Parsers
        class Base
          attr_reader :response

          def initialize(response)
            @response = response
          end

          def as_json(*)
            {
              number: number,
              name: name,
              description: description,
              hight: hight,
              weight: weight,
              category: category,
              abilities: abilities,
              gender: gender,
              types: types,
              weakness: weakness,
              stats: stats
            }
          end

          private

          def raw_body
            @raw_body ||= Nokogiri::HTML(response)
          end

          def raw_number
            raw_body.css(".pokedex-pokemon-pagination-title > div > .pokemon-number").children[0].text.strip
          rescue
            nil
          end

          def number
            raw_number[-4..].to_i if raw_number
          end

          def raw_name
            raw_body.css(".pokedex-pokemon-pagination-title > div").children[0].text
          rescue
            nil
          end

          def name
            raw_name&.strip if raw_name
          end

          def raw_description
            raw_body
              .css(".pokedex-pokemon-details-right")
              .css(".version-descriptions .active").children[0].text
          rescue
            nil
          end

          def description
            raw_description.strip if raw_description
          end

          def raw_hight
            raw_body
              .css(".pokedex-pokemon-details-right")
              .css(".pokemon-ability-info > .column-7 > .left-column > ul > li:nth-child(1) > span.attribute-value")
              .text
              .gsub(",", ".")
          rescue
            nil
          end

          def hight
            raw_hight[0..2].to_f if raw_hight
          end

          def raw_weight
            raw_body
              .css(".pokedex-pokemon-details-right")
              .css(".pokemon-ability-info > .column-7 > .left-column > ul > li:nth-child(2) > span.attribute-value")
              .text
              .gsub(",", ".")
          rescue
            nil
          end

          def weight
            raw_weight[0..2].to_f if raw_weight
          end

          def raw_category
            raw_body
              .xpath("/html/body/div[4]/section[3]/div[2]/div/div[4]/div[1]/div[2]/div/ul/li[1]/span[2]")
              .text
          rescue
            nil
          end

          def category
            raw_category.strip if raw_category
          end

          def raw_abilities
            raw_body
              .css(".pokedex-pokemon-details-right")
              .css(".pokemon-ability-info > .column-7 > .right-column > ul > li:nth-child(2) > ul.attribute-list > li > a > span")
              .children
          rescue
            []
          end

          def abilities
            raw_abilities.map(&:text).uniq.map(&:strip) if raw_abilities.any?
          end

          def raw_gender
            raw_body
              .css(".pokedex-pokemon-details-right")
              .css(".pokemon-ability-info > .column-7 > .left-column > ul > li:nth-child(3) > span.attribute-value > i")
              .map { |i| i.attribute("class").text }
              .uniq
          rescue
            []
          end

          def gender
            raw_gender.map { |g| g[/male|female/] } if raw_gender.any?
          end

          def raw_types
            raw_body
              .css(".pokedex-pokemon-attributes > .dtm-type > ul > li > a")
              .children
              .map(&:text)
              .uniq
              .map(&:strip)
          rescue
            []
          end

          def types
            raw_types if raw_types.any?
          end

          def raw_weakness
            raw_body
              .css(".dtm-weaknesses > ul > li > a > span")
              .children
              .map(&:text)
              .uniq
              .map(&:strip)
          rescue
            []
          end

          def weakness
            raw_weakness if raw_weakness.any?
          end

          def raw_stats_info
            raw_body.css(".pokemon-stats-info > ul")
          end

          def raw_stat_names
            raw_stats_info.css("li > span").map(&:text)
          end

          def raw_stat_index_value(index)
            raw_stats_info.css("li > ul > li:nth-child(1)")[index].attribute("data-value").value.to_i
          end

          def raw_stats
            raw_stat_names.each_with_object({}).with_index do |(stat, stats), index|
              stats[stat] = raw_stat_index_value(index)
            end
          end

          def stats
            raw_stats
          end
        end
      end
    end
  end
end
