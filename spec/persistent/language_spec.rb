# frozen_string_literal: true

require 'spec_helper'

describe Persistent::Language do
  describe '.all' do
    context 'when having unnormalized array of objects' do
      it 'returns normalized it by "name"' do
        outcome = described_class.all
        expect(outcome.count).to eq(97)
      end
    end
  end
end
