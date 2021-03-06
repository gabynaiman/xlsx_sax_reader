module XlsxSaxReader
  class Workbook

    def self.open(filename)
      begin
        workbook = self.new(filename)
        yield workbook
      ensure
        workbook.close
      end
    end

    def initialize(filename)
      @file_system = FileSystem.new filename
    end

    def close
      @file_system.close
    end

    def sheets(name=nil)
      @sheets ||= SheetCollection.new(@file_system, shared_strings).to_a
      name.nil? ? @sheets : @sheets.detect { |s| s.name == name }
    end

    def sheet_names
      sheets.map(&:name)
    end

    def shared_strings
      @shared_strings ||= SharedStringCollection.new(@file_system).to_a
    end

    def to_csv(path, parallel_options=nil)
      enumerable = parallel_options ? sheets.parallel(parallel_options) : sheets
      enumerable.each { |s| s.to_csv path }
    end

  end
end