# frozen_string_literal: true


describe LanguageNormalizer do
  let(:languages) { Persistent::Language.all }

  describe '.normalized_by_name' do
    context 'when having unnormalized array of objects' do
      let(:matched_languages) do
        ['ActionScript', 'AppleScript', 'AWK', 'bash', 'Candle', 'ColdFusion',
          'ECMAScript', 'Fancy', 'Groovy', 'JavaScript', 'JScript', 'Julia',
          'Lasso', 'Lua', 'Obix', 'Perl', 'PHP', 'Python', 'R', 'REXX', 'Ruby',
          'S-Lang', 'Smalltalk', 'VBScript', 'Windows PowerShell']
      end

      it 'returns normalized it by "type"' do
        outcome = described_class.new(languages).normalized_by_type
        expect(outcome['Scripting']).to eq(matched_languages)
      end
    end

    context 'when having unnormalized array of objects' do
      let(:matched_languages) do
        ['C#', 'JScript', 'VBScript', 'Visual Basic', 'Visual FoxPro',
          'Windows PowerShell', 'X++']
      end

      it 'returns normalized it by "designed by"' do
        outcome = described_class.new(languages).normalized_by_designed_by
        expect(outcome['Microsoft']).to eq(matched_languages)
      end
    end
  end

  describe '.types' do
    context 'when getting unique types' do
      let(:types) { 'Compiled|Curly-bracket|Procedural|Reflective|Scripting|Object-oriented class-based|Imperative|Iterative|Interpreted|Array|Interactive mode|Command line interface|Metaprogramming|Functional|Data-oriented|Declarative|Extension|Authoring' }

      it 'returns array of unique types' do
        outcome = described_class.new(languages).types
        expect(outcome).to eq(types)
      end
    end
  end
end
