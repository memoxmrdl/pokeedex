require "spec_helper"

RSpec.describe Pokeedex::Pokemon::Scrapper::Fetchers::Base do
  let(:url) { "https://www.example.com" }
  let(:fetcher) { described_class.new(url: url) }

  describe "#initialize" do
    it "sets the url" do
      expect(fetcher.url).to eq(url)
    end
  end

  describe "#content" do
    context "when the content is fetched successfully" do
      let(:content) { file_fixture("pokemon_com/responses/GET-200-bulbasaur.html") }

      before do
        allow(fetcher).to receive(:content).and_return(content)
      end

      it "returns the content" do
        expect(fetcher.content).to eq(content)
      end
    end

    context "when the content is not fetched successfully" do
      before do
        allow(fetcher).to receive(:browser).and_raise(Playwright::Error.new(message: "An error occurred"))
      end

      it "raises an Pokeedex::Exceptions::ScrapperError exception" do
        expect { fetcher.content }.to raise_error(Pokeedex::Exceptions::ScrapperError)
      end
    end
  end
end
