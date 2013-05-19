require 'spork'

Spork.prefork do
end

Spork.each_run do
  # This code will be run each time you run your specs.

end


require 'rspec-expectations'
require 'page-object'
require 'fig_newton'
require_relative './time_helper'

World(PageObject::PageFactory)
World(TimeHelper)
FigNewton.load "test.yml"

unless defined? CONSTANTS
  CONSTANTS = ''
  DB_URI = "sqlite://#{FigNewton.sqlite.relative_path}"
  IMPORT_FOLDER = FigNewton.import_folder_relative_path
end
