module XlsxFastReader
  class SharedStringCollection

    include Enumerable

    def initialize(workbook)
      @workbook = workbook
    end

    def each(&block)
      SharedStringCollectionParser.parse @workbook, &block
    end

  end
end