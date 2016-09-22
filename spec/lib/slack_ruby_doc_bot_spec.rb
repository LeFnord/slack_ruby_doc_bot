require 'spec_helper'

RSpec.describe SlackRubyDocBot::Bot do
  subject { described_class.instance }

  describe 'Bot' do
    it_behaves_like 'a slack ruby bot'
  end

  describe 'Commands' do
    specify 'doc class' do
      expect(message: 'doc FalseClass', channel: 'channel')
        .to respond_with_slack_message(
          /# FalseClass < Object\n\(from ruby core\)/
        )
    end

    specify 'class with method' do
      expect(message: 'FalseClass#to_s', channel: 'channel')
        .to respond_with_slack_message(
          /# FalseClass#to_s\n\(from ruby core\)/
        )
    end

    specify 'doc class with method' do
      expect(message: 'doc FalseClass#to_s', channel: 'channel')
        .to respond_with_slack_message(
          /# FalseClass#to_s\n\(from ruby core\)/
        )
    end
  end
end
