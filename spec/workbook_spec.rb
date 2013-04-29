require 'spec_helper'

describe Workbook do

  let(:filename) { "#{File.dirname(__FILE__)}/data/Spec.xlsx" }

  it 'Sheets count' do
    Workbook.open filename do |w|
      w.should have(4).sheets
    end
  end

  it 'Sheet names' do
    Workbook.open filename do |w|
      w.sheet_names.should eq %w(test_otros test_spec test_param Lenguajes)
    end
  end

  it 'Find sheet by index' do
    Workbook.open filename do |w|
      w.sheets[0].name.should eq 'test_otros'
      w.sheets[1].name.should eq 'test_spec'
      w.sheets[2].name.should eq 'test_param'
      w.sheets[3].name.should eq 'Lenguajes'
    end
  end

  it 'Find sheet by name' do
    Workbook.open filename do |w|
      w.sheets('test_otros').name.should eq 'test_otros'
      w.sheets('test_spec').name.should eq 'test_spec'
      w.sheets('test_param').name.should eq 'test_param'
      w.sheets('Lenguajes').name.should eq 'Lenguajes'
    end
  end

  it 'Shared strings' do
    Workbook.open filename do |w|
      w.should have(48).shared_strings
      w.shared_strings[0].should eq 'LevenshteinDistance'
      w.shared_strings[47].should eq 'default'
    end
  end

  it 'Export to CSV' do
    Workbook.open filename do |w|
      w.sheets.each { |s| s.should_receive(:to_csv).with(Dir.pwd) }
      w.to_csv Dir.pwd
    end
  end

  it 'Large xlsx' do
    #require 'ruby-prof'

    #result = RubyProf.profile do
    Workbook.open 'spec/data/SpecLarge.xlsx' do |w|
      w.sheets.parallel(in_processes: 4).each do |s|
        s.to_csv "#{File.dirname(__FILE__)}/../tmp"
      end
    end
    #end

    #printer = RubyProf::GraphHtmlPrinter.new(result)
    #File.open('profile.html', 'w') { |f| printer.print(f, {}) }
  end

end