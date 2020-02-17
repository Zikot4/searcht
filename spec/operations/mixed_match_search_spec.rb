# frozen_string_literal: true

require 'spec_helper'

describe MixedMatchSearch do
  before(:all) do
    @languages_obj = LanguageNormalizer.new(Persistent::Language.all)
    @languages = @languages_obj.normalized_by_name
  end

  let(:lang_obj) { @languages_obj }

  describe '#call' do
    context 'when got match by type' do
      let(:type) { 'Command line interface' }
      let(:matched_languages) do
        ['bash', 'csh', 'Expect', 'Hamilton C shell', 'ksh', 'REXX',
         'Windows PowerShell', 'zsh']
      end

      it 'returns an array of objects' do
        outcome = described_class.new(type, lang_obj).call
        expect(outcome).to eq(@languages.values_at(*matched_languages))
      end
    end

    context 'when got match by types' do
      let(:type) { 'Command line interface Scripting' }
      let(:matched_languages) { ['bash', 'REXX', 'Windows PowerShell'] }

      it 'returns an array of objects' do
        outcome = described_class.new(type, lang_obj).call
        expect(outcome).to eq(@languages.values_at(*matched_languages))
      end
    end

    context 'when got mixed match' do
      let(:type) { 'Command line interface Scripting Brian Fox' }
      let(:matched_languages) { ['bash'] }

      it 'returns an array of objects' do
        outcome = described_class.new(type, lang_obj).call
        expect(outcome).to eq(@languages.values_at(*matched_languages))
      end
    end

    context 'when got mixed match' do
      let(:type) { 'Scripting Microsoft' }
      let(:matched_languages) { ['JScript', 'VBScript', 'Windows PowerShell'] }

      it 'returns an array of objects' do
        outcome = described_class.new(type, lang_obj).call
        expect(outcome).to eq(@languages.values_at(*matched_languages))
      end
    end

    context 'when got mixed match with designed_by in the middle' do
      let(:type) { 'Command line interface Brian Fox Scripting' }
      let(:matched_languages) { ['bash'] }

      it 'returns an array of objects' do
        outcome = described_class.new(type, lang_obj).call
        expect(outcome).to eq(@languages.values_at(*matched_languages))
      end
    end

    context 'when got mixed match with designed_by at the beginning' do
      let(:type) { 'Brian Fox Command line interface  Scripting' }
      let(:matched_languages) { ['bash'] }

      it 'returns an array of objects' do
        outcome = described_class.new(type, lang_obj).call
        expect(outcome).to eq(@languages.values_at(*matched_languages))
      end
    end

    context 'when some word was missed' do
      let(:type) { 'Brian Fox Command line Scripting' }
      let(:matched_languages) { ['bash'] }

      it 'returns the empty array' do
        outcome = described_class.new(type, lang_obj).call
        expect(outcome).to eq([])
      end
    end

    context 'when got an extra word' do
      let(:type) { 'Brian Fox Command line interface Scripting Proc' }
      let(:matched_languages) { ['bash'] }

      it 'returns the empty array' do
        outcome = described_class.new(type, lang_obj).call
        expect(outcome).to eq([])
      end
    end
  end
end
