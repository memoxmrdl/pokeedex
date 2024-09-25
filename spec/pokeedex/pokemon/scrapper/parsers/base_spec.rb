require 'spec_helper'

RSpec.describe Pokeedex::Pokemon::Scrapper::Parsers::Base do
  let(:response) { file_fixture('pokemon_com/responses/GET-200-bulbasaur.html') }
  let(:parser) { described_class.new(response) }

  describe '#as_json' do
    subject { parser.as_json }

    context 'when the response is valid' do
      it 'returns the parsed data' do
        is_expected.to eq({
                            number: 1,
                            name: 'Bulbasaur',
                            description: 'Tras nacer, crece alimentándose durante un tiempo de los nutrientes que contiene el bulbo de su lomo.',
                            hight: 0.7,
                            weight: 6.9,
                            category: 'Semilla',
                            abilities: ['Espesura'],
                            gender: %w[male female],
                            types: %w[Planta Veneno],
                            weakness: %w[Fuego Hielo Volador Psíquico],
                            stats: { 'PS' => 3, 'Ataque' => 3, 'Defensa' => 3, 'Ataque Especial' => 4, 'Defensa Especial' => 4,
                                     'Velocidad' => 3 }
                          })
      end
    end

    context 'when the response is invalid' do
      let(:response) { nil }

      it 'returns an empty hash' do
        is_expected.to eq({
                            abilities: nil,
                            category: '',
                            description: nil,
                            gender: nil,
                            hight: 0.0,
                            name: nil,
                            number: nil,
                            stats: {},
                            types: nil,
                            weakness: nil,
                            weight: 0.0
                          })
      end
    end
  end
end
