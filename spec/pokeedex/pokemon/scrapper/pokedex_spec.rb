require "spec_helper"

RSpec.describe Pokeedex::Pokemon::Scrapper::Pokedex do
  let(:number_or_name) { 1 }
  let(:pokedex) { described_class.new(number_or_name: number_or_name) }

  describe "#initialize" do
    it "assigns the number_or_name" do
      expect(pokedex.number_or_name).to eq(number_or_name)
    end
  end

  describe "#url" do
    let(:expected_url) { "#{described_class::BASE_URI}/#{number_or_name}" }

    it "returns the url" do
      expect(pokedex.url).to eq(expected_url)
    end
  end

  describe "#crawl" do
    let(:fetcher) { instance_double(Pokeedex::Pokemon::Scrapper::Fetchers::Base) }
    let(:content) { file_fixture("pokemon_com/responses/GET-200-bulbasaur.html") }

    subject { pokedex.crawl }

    before do
      allow(Pokeedex::Pokemon::Scrapper::Fetchers::Base).to receive(:new).and_return(fetcher)
      allow(fetcher).to receive(:content).and_return(content)
    end

    context "when crawler is successfully" do
      it "returns the parsed data" do
        is_expected.to eq({
          number: 1,
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
        })
      end
    end

    context "when crawler is failed" do
      let(:content) { file_fixture("pokemon_com/responses/GET-404-not-found.html") }

      it "returns the parsed data" do
        is_expected.to eq({
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
        })
      end
    end
  end
end
