module XlsxFastReader
  class Sheet

    attr_reader :name

    def initialize(workbook, name, index)
      @workbook = workbook
      @name = name
      @index = index
    end

    def rows
      @rows ||= RowsCollection.new(@workbook, @index).to_a
    end

  end
end