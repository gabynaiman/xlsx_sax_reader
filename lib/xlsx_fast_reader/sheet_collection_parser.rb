module XlsxFastReader
  class SheetCollectionParser < Ox::Sax

    CurrentSheet = Struct.new :index, :name

    def self.parse(workbook, &block)
      SaxParser.parse self.new(workbook, &block), workbook.read_file('xl/workbook.xml')
    end

    def initialize(workbook, &block)
      @workbook = workbook
      @block = block
      @index = 0
    end

    def start_element(name)
      @current_sheet = CurrentSheet.new(@index += 1) if name == :sheet
    end

    def end_element(name)
      if name == :sheet
        @block.call Sheet.new(@workbook, @current_sheet.name, @current_sheet.index)
        @current_sheet = nil
      end
    end

    def attr(name, value)
      @current_sheet.name = value if @current_sheet && name == :name
    end

  end
end