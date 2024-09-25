require "spec_helper"

RSpec.describe Pokeedex::Exceptions do
  describe ".ScrapperError" do
    subject { described_class::ScrapperError.new }

    it "returns a ScrapperError instance" do
      is_expected.to be_instance_of(described_class::ScrapperError)
    end
  end
end
