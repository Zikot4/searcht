# frozen_string_literal: true

module Persistent
  class Language
    RELATIVE_PATH_TO_FILE = 'storage/data.json'

    class << self
      def all
        JSON.parse(File.open(RELATIVE_PATH_TO_FILE).read)
      end
    end
  end
end
