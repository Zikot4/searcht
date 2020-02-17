# frozen_string_literal: true

require 'spec_helper'

describe ExactMatchSearch do
  before(:all) do
    @languages_obj = LanguageNormalizer.new(Persistent::Language.all)
    @languages = @languages_obj.normalized_by_name
  end

  let(:lang_obj) { @languages_obj }

  describe '#call' do
    context 'when got exact match by language' do
      let(:lang_name) { 'Common Lisp' }

      it 'returns an array of objects' do
        outcome = described_class.new(lang_name, lang_obj).call
        expect(outcome).to eq([@languages[lang_name]])
      end
    end

    context 'when got match with rotated words by language' do
      let(:rotated_name) { 'Lisp Common' }
      let(:lang_name) { 'Common Lisp' }

      it 'returns an object' do
        outcome = described_class.new(rotated_name, lang_obj).call
        expect(outcome).to eq([@languages[lang_name]])
      end
    end

    context 'when some word was missed' do
      let(:lang_name) { 'Common' }

      it 'returns the empty array' do
        outcome = described_class.new(lang_name, lang_obj).call
        expect(outcome).to eq([])
      end
    end

    context 'when got an extra word' do
      let(:lang_name) { 'Common List Curl' }

      it 'returns the empty array' do
        outcome = described_class.new(lang_name, lang_obj).call
        expect(outcome).to eq([])
      end
    end

    context 'when got exact match by designed_by' do
      let(:lang_name) { 'BASIC' }
      let(:designed_by) { 'Thomas Eugene Kurtz' }

      it 'returns an array of objects' do
        outcome = described_class.new(designed_by, lang_obj).call
        expect(outcome).to eq([@languages[lang_name]])
      end
    end
  end
end
