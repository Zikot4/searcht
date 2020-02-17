# frozen_string_literal: true

require 'json'
require 'benchmark'

require_relative 'app/operations/exact_match_search.rb'
require_relative 'app/operations/mixed_match_search.rb'
require_relative 'app/operations/search.rb'
require_relative 'app/persistent/language.rb'
require_relative 'app/normalizers/language_normalizer.rb'

search = Search.new(
  'Yukihiro Matsumoto', LanguageNormalizer.new(Persistent::Language.all)
)

Benchmark.bm do |x|
  x.report do
    p search.call
  end
end
