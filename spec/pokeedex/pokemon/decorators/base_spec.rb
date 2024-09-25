require "spec_helper"
require "ostruct"

RSpec.describe Pokeedex::Pokemon::Decorators::Base do
  let(:decorator) { described_class }
  let(:pokemon) do
    OpenStruct.new(
      number: 1,
      name: "Bulbasaur",
      description: "Tras nacer, crece alimentándose durante un tiempo de los nutrientes que contiene el bulbo de su lomo.",
      hight: 0.7,
      weight: 6.9,
      category: "Semilla",
      abilities: ["Espesura"],
      gender: ["male", "female"],
      types: ["Planta", "Veneno"],
      weakness: ["Fuego", "Hielo", "Volador", "Psíquico"],
      stats: {"PS" => 3, "Ataque" => 3, "Defensa" => 3, "Ataque Especial" => 4, "Defensa Especial" => 4, "Velocidad" => 3}
    )
  end

  describe "#to_s" do
    let(:expected) do
      <<~DECORATOR
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

      DECORATOR
    end

    subject { decorator.new(pokemon).to_s }

    context "when the pokemon is present" do
      it "returns the decorated pokemon" do
        expect(subject).to eq(expected)
      end
    end

    context "when the pokemon is not present" do
      let(:pokemon) { nil }

      it 'returns the message "Pokemon\'s not found"' do
        expect(subject).to eq("Pokemon's not found")
      end
    end
  end
end
