require "spec_helper"

RSpec.describe Pokeedex::Pokemon::Base do
  let(:query) { "bulbasaur" }

  describe ".search" do
    subject { described_class.search(query) }

    context "when a pokemon is searched" do
      it "returns a searcher object" do
        is_expected.to be_an_instance_of(Pokeedex::Pokemon::Searcher::Base)
      end
    end
  end
end
