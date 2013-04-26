module XlsxFastReader
  class ColumnNameGenerator

    LETTERS = ('A'..'ZZZ').to_a.freeze

    def self.first
      LETTERS.first
    end

    def self.next_to(value)
      return first if value.nil? || value.empty?

      index = LETTERS.find_index(value)
      LETTERS[index+1]
    end

  end
end