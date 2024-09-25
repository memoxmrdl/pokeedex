require 'spec_helper'

RSpec.describe Pokeedex::Pokemon::Model::Base do
  describe '#validate' do
    let(:attributes) do
      {
        number: 1,
        name: 'Bulbasaur',
        description: 'Tras nacer, crece alimentándose durante un tiempo de los nutrientes que contiene el bulbo de su lomo.',
        hight: 0.7,
        weight: 6.9,
        category: '',
        abilities: ['Espesura'],
        gender: %w[male female],
        types: %w[Planta Veneno],
        weakness: %w[Fuego Hielo Volador Psíquico],
        stats: { 'PS' => 3, 'Ataque' => 3, 'Defensa' => 3, 'Ataque Especial' => 4, 'Defensa Especial' => 4,
                 'Velocidad' => 3 }
      }
    end

    subject { described_class.new(attributes) }

    context 'when the pokemon is valid' do
      it {
        is_expected.to be_valid
      }
    end

    context 'when the pokemon is invalid' do
      let(:attributes) { {} }

      it { is_expected.not_to be_valid }
    end
  end
end
