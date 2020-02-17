# frozen_string_literal: true

class ExactMatchSearch
  def initialize(query, lang_obg)
    @normalized_by_name   = lang_obg.normalized_by_name
    @normalized_by_design = lang_obg.normalized_by_designed_by
    @query = query
  end

  def call
    languages = search_by_name(query)
    if languages.empty?
      languages = normalized_by_design[query]
      languages = normalized_by_name.values_at(*languages)
    end
    languages
  end

  private

  attr_reader :normalized_by_name, :normalized_by_design, :query

  def search_by_name(query)
    result = []

    query.split(' ').permutation.to_a.each do |combination|
      language = normalized_by_name[combination.join(' ')]

      result << language if language
    end
    result
  end
end
