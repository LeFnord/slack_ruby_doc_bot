require 'spec_helper'

RSpec.describe SlackRubyDocBot::Concerns::Doc do
  subject { described_class }

  let(:klass) { 'Array' }

  describe 'no args given' do
    let(:object) { subject.call! }

    specify { expect(object).to eql '… uups, you forgot a class or module' }
  end

  describe 'klass' do
    describe 'valid klass given' do
      let(:object) { subject.call!(klass: klass) }

      specify { expect(object).to start_with "# #{klass} < Object\n" }
    end

    describe 'invalid klass given' do
      let(:klass) { 'WrongClass' }
      let(:object) { subject.call!(klass: klass) }

      specify { expect(object).to eql "Nothing known about #{klass} … did you misspelled it?" }
    end
  end

  describe 'method' do
    describe 'klass and valid method' do
      let(:object) { subject.call!(klass: klass, method: 'first') }

      specify { expect(object).to start_with "# #{klass}#first\n(from ruby" }
    end

    describe 'klass and invalid method' do
      let(:object) { subject.call!(klass: klass, method: 'foo') }

      specify { expect(object).to eql "Nothing known about #{klass}#foo … did you misspelled it?" }
    end

    describe 'klass and misspelled method' do
      let(:method) { 'firs' }
      let(:object) { subject.call!(klass: klass, method: method) }

      specify { expect(object).to start_with "#{klass}##{method} not found, maybe you meant:" }
    end

    describe 'klass and method to encode' do
      let(:object) { subject.call!(klass: klass, method: '&lt;&lt;') }

      specify { expect(object).to start_with "# #{klass}#<<\n(from ruby" }
    end
  end
end
