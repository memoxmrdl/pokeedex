# Pokeedex

Pokeedex is a Ruby gem that provides an interface to interact with the [Pokémon Pokédex](https://www.pokemon.com/el/pokedex). It allows you to retrieve detailed information about Pokémon, including their stats, abilities, types, and evolutions. This gem is ideal for developers who want to integrate Pokémon data into their Ruby applications easily and efficiently.

## Features

- Search for Pokémon by name or number.
- Retrieve detailed stats for each Pokémon.
- Information about Pokémon abilities and types.

### Next comming features

- Data on Pokémon evolutions.
- Support multilanguage.
- Find pokemon's by types

## Requirements

- NodeJS v18^

Pokedex requires [Playwright](https://playwright.dev/) to perform Web Scraping to obtain information about a Pokemon from [https://www.pokemon.com/el/pokedex](https://www.pokemon.com/el/pokedex). For Ruby, use the [playwright-ruby-client](https://playwright-ruby-client.vercel.app/) gem client to be able to interact with Playwright and use the browser that is part of the library installed. For the use of the browser, use an executable to be able to use the browser in Headless mode.

For default Pokeedex use Chronium browser (You don't need install a browser).

## Installation

To install the gem and add it to your application's Gemfile, execute:

    $ bundle add pokeedex

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install pokeedex

or

Clone the repository on your local and access to code and use it

    $ git clone git@github.com:memoxmrdl/pokeedex.git
    $ cd pokeedex

## Usage

### CLI

For use pokeedex you only need execute from your terminal the following command, if you are used `gem install`:

```
$ pokeedex --help
Usage: pokeedex [number|name]
    -h, --help                       Prints this help

```

NOTE: If you are cloned the repository from on your local then use:

```
$ bin/pokeedex --help
Usage: pokeedex [number|name]
    -h, --help                       Prints this help

```

NOTE: If you do not have NodeJS installed you may be prompted that they need to be installed, please check the requirements and try again.

### API

```
# pokeedex_api.rb

require 'pokeedex'

Pokeedex.init

begin
  query = 'pikachu'

  pokemons = Pokeedex::Pokemon::Base.search(query)
  pokemon = pokemons.first

  puts pokemon.number
  puts pokemon.name
rescue Pokeedex::Exceptions::ScrapperError => e
  puts e.message
end
```

### Example outputs

#### Find by number

```
$ bin/pokeedex 1
Número: 1
Nombre: Bulbasaur
Descripción: Tras nacer, crece alimentándose durante un tiempo de los nutrientes que contiene el bulbo de su lomo.
Altura: 0.7 m
Peso: 6.9 kg
Categoría: Semilla
Habilidades: Espesura
Genero: Macho, Hembra
Tipo: Planta, Veneno
Habilidades: Fuego, Hielo, Volador, Psíquico

Puntos de base
###------------ PS
###------------ Ataque
###------------ Defensa
####----------- Ataque Especial
####----------- Defensa Especial
###------------ Velocidad
```

#### Find by name

```
$ bin/pokeedex pikachu
Número: 25
Nombre: Pikachu
Descripción: Cuando se enfada, este Pokémon descarga la energía que almacena en el interior de las bolsas de las mejillas.
Altura: 0.4 m
Peso: 6.0 kg
Categoría: Ratón
Habilidades: Elec. Estática
Genero: Macho, Hembra
Tipo: Eléctrico
Habilidades: Tierra

Puntos de base
###------------ PS
####----------- Ataque
###------------ Defensa
###------------ Ataque Especial
###------------ Defensa Especial
######--------- Velocidad
```

## I hate you IMPERVA!

Me la pelaste!

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pokeedex. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/pokeedex/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Pokeedex project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/pokeedex/blob/main/CODE_OF_CONDUCT.md).
