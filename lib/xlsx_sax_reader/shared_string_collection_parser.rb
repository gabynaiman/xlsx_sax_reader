module XlsxSaxReader
  class SharedStringCollectionParser < Ox::Sax

    def self.parse(workbook, &block)
      SaxParser.parse self.new(&block), workbook.read_file('xl/sharedStrings.xml')
    end

    def initialize(&block)
      @block = block
    end

    def start_element(name)
      @current_string = '' if name == :si
    end

    def end_element(name)
      if name == :si
        @block.call @current_string
        @current_string = nil
      end
    end

    def text(value)
      @current_string << value if @current_string
    end

  end
end