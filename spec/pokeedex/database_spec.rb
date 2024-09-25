require "spec_helper"

RSpec.describe Pokeedex::Database do
  let(:config) { Pokeedex::Configuration.new }

  describe ".connect" do
    subject { described_class.connect(config) }

    it "returns a Sequel::SQLite::Database instance" do
      is_expected.to be_instance_of(Sequel::SQLite::Database)
    end
  end

  describe ".connection" do
    subject { described_class.connection }

    it "returns a Sequel::SQLite::Database instance" do
      is_expected.to be_instance_of(Sequel::SQLite::Database)
    end
  end
end
