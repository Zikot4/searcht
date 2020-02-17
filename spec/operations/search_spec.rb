# frozen_string_literal: true

require 'spec_helper'

describe Search do
  describe '#call' do
    let(:lang_obj) { LanguageNormalizer.new(Persistent::Language.all) }

    context 'when query have not included types' do
      let(:query) { 'Ruby' }

      it 'calls "ExactMatchSearch" service' do
        allow_any_instance_of(ExactMatchSearch).to receive(:call).and_return(
          'ExactMatchSearch'
        )

        outcome = described_class.new(query, lang_obj).call
        expect(outcome).to eq('ExactMatchSearch')
      end
    end

    context 'when query have included types' do
      let(:query) { 'Yukihiro Matsumoto Scripting' }

      it 'calls "ExactMatchSearch" service' do
        allow_any_instance_of(MixedMatchSearch).to receive(:call).and_return(
          'MixedMatchSearch'
        )

        outcome = described_class.new(query, lang_obj).call
        expect(outcome).to eq('MixedMatchSearch')
      end
    end
  end
end
