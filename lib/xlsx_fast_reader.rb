require 'zip/zip'
require 'zip/zipfilesystem'
require 'ox'

Dir["#{File.dirname(__FILE__)}/xlsx_fast_reader/**/*.rb"].each { |f| require f }
