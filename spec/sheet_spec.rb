require 'spec_helper'

describe Sheet do

  let(:filename) { 'spec/data/Spec.xlsx' }

  it 'Rows count' do
    Workbook.open filename do |w|
      w.sheets[0].should have(7).rows
      w.sheets[1].should have(9).rows
      w.sheets[2].should have(3).rows
      w.sheets[3].should have(2).rows
    end
  end

  it 'Rows content' do
    Workbook.open filename do |w|
      w.sheets[0].tap do |s|
        s.rows[0].should eq ['LevenshteinDistance', 0]
        s.rows[1].should eq ['Case sensitive', false]
        s.rows[2].should eq ['Fields', 'Type', 'URL Mining']
        s.rows[3].should eq ['autor', 'text', false]
        s.rows[4].should eq ['texto', 'text', false]
        s.rows[5].should eq ['url', 'text', false]
        s.rows[6].should eq ['comentario', 'text', false]
      end
    end
  end

  it 'Rows content skipping cells' do
    Workbook.open filename do |w|
      w.sheets[3].tap do |s|
        s.rows[0].should eq [nil, 'en', 'es', 'pt', 'un']
        s.rows[1].should eq ['default', 30, 50, 15, 5]
      end
    end
  end

end