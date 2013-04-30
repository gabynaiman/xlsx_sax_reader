module XlsxSaxReader
  class RowsCollection

    include Enumerable

    def initialize(index, file_system, shared_strings)
      @index = index
      @file_system = file_system
      @shared_strings = shared_strings
    end

    def each(&block)
      RowsCollectionParser.parse @index, @file_system, @shared_strings, &block
    end

  end
end