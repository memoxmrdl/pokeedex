module Pokeedex
  module Pokemon
    module Decorators
      class Base
        attr_reader :pokemon

        GENDER = {
          "male" => "Macho",
          "female" => "Hembra"
        }.freeze

        MAXIMUM_STAT_VALUE = 15

        def initialize(pokemon)
          @pokemon = pokemon
        end

        def to_s
          decorate
        end

        private

        def decorate
          return "Pokemon's not found" unless pokemon

          <<~DECORATOR
            Número: #{number}
            Nombre: #{name}
            Descripción: #{description}
            Altura: #{hight} m
            Peso: #{weight} kg
            Categoría: #{category}
            Habilidades: #{abilities}
            Genero: #{gender}
            Tipo: #{types}
            Habilidades: #{weakness}

            Puntos de base
            #{stats}
          DECORATOR
        end

        def number = pokemon.number

        def name = pokemon.name

        def description = pokemon.description

        def hight = pokemon.hight

        def weight = pokemon.weight

        def category = pokemon.category

        def abilities = pokemon.abilities.join(", ")

        def gender
          pokemon.gender.map { |g| GENDER[g] }.join(", ")
        end

        def types = pokemon.types.join(", ")

        def weakness = pokemon.weakness.join(", ")

        def stats
          pokemon.stats.each_with_object("").each do |(key, value), stats_decorate|
            stats_decorate << "#{display_graph(value, MAXIMUM_STAT_VALUE)} #{key}\n"
          end
        end

        def display_graph(value, max_value)
          value = [[value, 1].max, max_value].min

          total_chars = max_value
          filled_chars = (value.to_f / max_value * total_chars).round
          empty_chars = total_chars - filled_chars

          "#" * filled_chars + "-" * empty_chars
        end
      end
    end
  end
end
