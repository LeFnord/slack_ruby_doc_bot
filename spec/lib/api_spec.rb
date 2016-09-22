require 'spec_helper'

RSpec.describe SlackRubyDocBot::Api do
  include Rack::Test::Methods

  let(:app) { SlackRubyDocBot::Api }

  let(:exposed_keys) do
    [
      :verb,
      :path,
      :description
    ]
  end

  subject { get '/api' }
  specify { expect(subject.status).to eql 200 }

  let(:response) { JSON.parse(subject.body, symbolize_names: true) }

  specify { expect(response.keys).to eql [:bot] }
end
