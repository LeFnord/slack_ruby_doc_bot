$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'slack-ruby-bot/rspec'

require 'support/respond_with_slack_message'

require 'slack_ruby_doc_bot'
require 'api'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.profile_examples = 3
  config.order = :random
  Kernel.srand config.seed
end
