require 'spec_helper'

RSpec.describe Pokeedex::Configuration do
  describe '#initialize' do
    subject { described_class.new }

    it 'returns a Configuration instance' do
      is_expected.to be_instance_of(described_class)
    end

    it 'returns the default values' do
      expect(subject.playwright_cli_executable_path).to eq(
        File.join(Pokeedex.root_path, 'node_modules', '.bin', 'playwright')
      )
      expect(subject.db_name).to eq('pokeedex_local.sqlite3')
    end
  end

  describe '#db_name=' do
    subject { described_class.new }

    it 'returns the db_path' do
      subject.db_name = 'pokeedex_test.sqlite3'
      expect(subject.db_path).to eq(
        File.join(Pokeedex.root_path, 'lib', 'pokeedex', 'db', 'pokeedex_test.sqlite3')
      )
    end
  end

  describe '#db_connection' do
    subject { described_class.new }

    it 'returns a Sequel::SQLite::Database instance' do
      expect(subject.db_connection).to be_instance_of(Sequel::SQLite::Database)
    end
  end
end
