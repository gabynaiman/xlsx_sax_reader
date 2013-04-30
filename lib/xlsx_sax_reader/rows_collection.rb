module XlsxSaxReader
  class RowsCollection

    include Enumerable

    def initialize(workbook, index)
      @workbook = workbook
      @index = index
    end

    def each(&block)
      RowsCollectionParser.parse @workbook, @index, &block
    end

  end
end