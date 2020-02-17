# frozen_string_literal: true

class MixedMatchSearch
  def initialize(query, lang_obg)
    @normalized_by_name = lang_obg.normalized_by_name
    @normalized_by_type = lang_obg.normalized_by_type
    @normalized_by_design = lang_obg.normalized_by_designed_by
    @languages_types = lang_obg.types
    @query = query
  end

  def call
    @query = query.gsub(Regexp.new(types_from_query.join('|')), '').strip
    return normalized_by_name.values_at(*languages_by_types) if query.empty?

    normalized_by_name.values_at(
      *(normalized_by_design[query] & languages_by_types)
    )
  end

  private

  attr_reader :normalized_by_type, :normalized_by_design, :languages_types,
              :query, :normalized_by_name

  def languages_by_types
    @languages_by_types ||= begin
      langs = normalized_by_type[types_from_query[0]]

      types_from_query[1..-1].each { |type| langs &= normalized_by_type[type] }
      langs
    end
  end

  def types_from_query
    @types_from_query ||= query.scan(Regexp.new(languages_types))
  end
end
