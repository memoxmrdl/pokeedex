require "spec_helper"

RSpec.describe Pokeedex::Pokemon::Searcher::Base do
  let(:query) { "bulbasaur" }
  let(:searcher) { described_class.new(query) }

  describe "#initialize" do
    it "sets the query" do
      expect(searcher.query).to eq(query)
    end
  end

  describe "#records" do
    let(:pokedex) { instance_double Pokeedex::Pokemon::Scrapper::Pokedex }
    let(:content) do
      {
        name: "Bulbasaur",
        description: "Tras nacer, crece alimentándose durante un tiempo de los nutrientes que contiene el bulbo de su lomo.",
        hight: 0.7,
        weight: 6.9,
        category: "",
        abilities: ["Espesura"],
        gender: ["male", "female"],
        types: ["Planta", "Veneno"],
        weakness: ["Fuego", "Hielo", "Volador", "Psíquico"],
        stats: {"PS" => 3, "Ataque" => 3, "Defensa" => 3, "Ataque Especial" => 4, "Defensa Especial" => 4, "Velocidad" => 3}
      }
    end

    subject { searcher.records }

    before do
      allow(Pokeedex::Pokemon::Scrapper::Pokedex).to receive(:new).and_return(pokedex)
      allow(pokedex).to receive(:crawl).and_return(content)
    end

    context "when a pokemon doesn't exist on the DB then it needs request remotely and create it" do
      it "returns an array with the pokemon" do
        expect(subject).to be_an_instance_of(Array)
        expect(subject.size).to eq(1)
        expect(subject.first).to be_an_instance_of(Pokeedex::Pokemon::Model::Base)
      end
    end

    context "when a pokemon exists on the DB" do
      let(:pokemon) { Pokeedex::Pokemon::Model::Base.create(content) }

      it "returns an array with the pokemon" do
        expect(subject).to be_an_instance_of(Array)
        expect(subject.size).to eq(1)
        expect(subject.first).to eq(pokemon)
      end
    end

    context "when a pokemon doesn't exist on the DB and the request remotely fails" do
      let(:content) do
        {
          abilities: nil,
          category: "",
          description: nil,
          gender: nil,
          hight: 0.0,
          name: nil,
          number: nil,
          stats: {},
          types: nil,
          weakness: nil,
          weight: 0.0
        }
      end

      before do
        allow(pokedex).to receive(:crawl).and_raise(content)
      end

      it "returns an empty array" do
        expect(subject).to be_empty
      end
    end
  end
end
