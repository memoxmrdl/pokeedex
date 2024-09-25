require_relative "spec_helper"

RSpec.describe Pokeedex do
  it "has a version number" do
    expect(Pokeedex::VERSION).not_to be nil
  end
end
