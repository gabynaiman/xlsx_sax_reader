module XlsxFastReader
  class SheetCollection

    include Enumerable

    def initialize(workbook)
      @workbook = workbook
    end

    def each(&block)
      SheetCollectionParser.parse @workbook, &block
    end

  end
end