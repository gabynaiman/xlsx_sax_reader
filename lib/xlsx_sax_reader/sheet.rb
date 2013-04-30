module XlsxSaxReader
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

    def to_csv(path)
      FileUtils.mkpath path unless Dir.exists? path
      File.open("#{path}/#{name}.csv", 'w') do |f|
        rows.each do |row|
          f.puts row.map{|c| "\"#{c}\""}.join(',')
        end
      end
    end

  end
end