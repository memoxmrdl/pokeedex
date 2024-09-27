module Pokeedex # :nodoc:
  module Pokemon # :nodoc:
    module Decorators # :nodoc:
      ##
      # Base class for the Pokemon decorators
      # This class is used to decorate the Pokemon object with additional information and format it for display to the user in the CLI or other interfaces.
      # The class is initialized with a Pokemon object and has a method to return the decorated Pokemon object as a string for display to the user in the CLI or other interfaces with the following information:
      # ==== For example
      #   Número: 1
      #   Nombre: Bulbasaur
      #   Descripción: Tras nacer, crece alimentándose durante un tiempo de los nutrientes que contiene el bulbo de su lomo.
      #   Altura: 0.7 m
      #   Peso: 6.9 kg
      #   Categoría:
      #   Habilidades: Espesura
      #   Genero: Macho, Hembra
      #   Tipo: Planta, Veneno
      #   Habilidades: Fuego, Hielo, Volador, Psíquico
      #
      #   Puntos de base
      #   ###------------ PS
      #   ###------------ Ataque
      #   ###------------ Defensa
      #   ####----------- Ataque Especial
      #   ###----------- Defensa Especial
      #   ###------------ Velocidad
      #
      class Base
        ##
        # The Pokemon object to decorate. Receive a Pokemon object to decorate of Pokeedex::Pokemon::Model::Base class
        attr_reader :pokemon

        GENDER = {
          'male' => 'Macho',
          'female' => 'Hembra'
        }.freeze

        MAXIMUM_STAT_VALUE = 15

        def initialize(pokemon)
          @pokemon = pokemon
        end

        ##
        # Return the decorated Pokemon object as a string for display to the user in the CLI or other interfaces
        def to_s
          build_decorate
        end

        private

        def build_decorate
          "Pokemon's not found" unless pokemon

          build_information
        end

        def build_information
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

        def abilities = pokemon.abilities.join(', ')

        def gender
          return 'Desconocido' unless pokemon.gender

          pokemon.gender.map { |g| GENDER[g] }.join(', ')
        end

        def types = pokemon.types.join(', ')

        def weakness = pokemon.weakness.join(', ')

        def stats
          pokemon.stats.each_with_object('').each do |(key, value), stats_decorate|
            stats_decorate << "#{display_graph(value, MAXIMUM_STAT_VALUE)} #{key}\n"
          end
        end

        def display_graph(value, max_value)
          value = [[value, 1].max, max_value].min

          total_chars = max_value
          filled_chars = (value.to_f / max_value * total_chars).round
          empty_chars = total_chars - filled_chars

          '#' * filled_chars + '-' * empty_chars
        end
      end
    end
  end
end
