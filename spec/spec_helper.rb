$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "pokeedex"
require "webmock/rspec"

Pokeedex.configure do |config|
  config.db_name = "pokeedex_test.sqlite3"
end

Pokeedex.boot

def file_fixture(filename)
  open(File.join(File.dirname(__FILE__), "fixtures", "#{filename}")).read
end

Dir[File.expand_path(File.join(File.dirname(__FILE__), "support", "**", "*.rb"))].each { |f| require f }

RSpec.configure do |config|
  config.after(:suite) do
    Pokeedex::Database.clean!
  end

  config.after(:each) do
    Pokeedex::Database.clean!
  end

  config.after(:context) do
    Pokeedex::Database.clean!
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = false
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!

  config.warnings = true

  config.profile_examples = 10

  config.order = :random
end
