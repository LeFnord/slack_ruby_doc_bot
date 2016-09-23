require 'spec_helper'

RSpec.describe SlackRubyDocBot::Bot do
  subject { described_class.instance }

  describe 'Bot' do
    it_behaves_like 'a slack ruby bot'
  end

  describe 'Commands' do
    specify 'doc class' do
      expect(message: 'doc Array', channel: 'channel')
        .to respond_with_slack_message(
          /# Array < Object\n/
        )
    end

    specify 'class with method' do
      expect(message: 'Array#first', channel: 'channel')
        .to respond_with_slack_message(
          /# Array#first\n\(from ruby/
        )
    end

    specify 'doc class with method' do
      expect(message: 'doc Array#first', channel: 'channel')
        .to respond_with_slack_message(
          /# Array#first\n\(from ruby/
        )
    end
  end
end
