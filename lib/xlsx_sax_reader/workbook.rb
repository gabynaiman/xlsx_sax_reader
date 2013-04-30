module XlsxSaxReader
  class Workbook

    def self.open(filename)
      workbook = self.new(filename)
      yield workbook
      workbook.close
    end

    def initialize(filename)
      @zip = Zip::ZipFile.open filename
    end

    def close
      @zip.close
    end

    def read_file(filename)
      @zip.read filename
    end

    def sheets(name=nil)
      @sheets ||= SheetCollection.new(self).to_a
      name.nil? ? @sheets : @sheets.detect { |s| s.name == name }
    end

    def sheet_names
      sheets.map(&:name)
    end

    def shared_strings
      @shared_strings ||= SharedStringCollection.new(self).to_a
    end

    def to_csv(path, parallel_options=nil)
      enumerable = parallel_options ? sheets.parallel(parallel_options) : sheets
      enumerable.each { |s| s.to_csv path }
    end

  end
end