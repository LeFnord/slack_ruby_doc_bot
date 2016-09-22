require 'spec_helper'

RSpec.describe SlackRubyDocBot::Concerns::Doc do
  subject { described_class }

  describe 'no args given' do
    let(:object) { subject.call! }

    specify { expect(object).to eql '… uups, you forgot a class or module' }
  end

  describe 'valid klass given' do
    let(:object) { subject.call!(klass: 'FalseClass') }

    specify { expect(object).to start_with "# FalseClass < Object\n\(from ruby core\)" }
  end

  describe 'invalid klass given' do
    let(:klass) { 'WrongClass' }
    let(:object) { subject.call!(klass: klass) }

    specify { expect(object).to eql "Nothing known about #{klass} … did you misspelled it?" }
  end
end
