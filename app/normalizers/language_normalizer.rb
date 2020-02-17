# frozen_string_literal: true

class LanguageNormalizer
  def initialize(languages)
    @languages = languages
  end

  attr_reader :languages

  def normalized_by_name
    @normalized_by_name ||= begin
      @normalized_by_name = {}
      languages.each { |obj| normalized_by_name[obj['Name']] = obj }
      normalized_by_name
    end
  end

  def normalized_by_type
    @normalized_by_type ||= normalized_by('Type')
  end

  def normalized_by_designed_by
    @normalized_by_designed_by ||= normalized_by('Designed by')
  end

  def types
    @types ||= normalized_by_type.keys.join('|').strip
  end

  private

  def normalized_by(key)
    normalized_by_type = Hash.new([])

    languages.each do |obj|
      types = obj[key].split(', ')

      types.each do |type|
        next if type.strip.empty?

        normalized_by_type[type] += [obj['Name']]
      end
    end
    normalized_by_type
  end
end
