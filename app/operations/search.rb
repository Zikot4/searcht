# frozen_string_literal: true

class Search
  def initialize(query, lang_obg)
    @lang_obg = lang_obg
    @languages_types = lang_obg.types
    @query = query
  end

  def call
    return ExactMatchSearch.new(query, lang_obg).call unless types_exist?

    MixedMatchSearch.new(query, lang_obg).call
  end

  private

  attr_reader :languages_types, :query, :lang_obg

  def types_exist?
    query.match?(Regexp.new(languages_types))
  end
end
