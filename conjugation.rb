#!/usr/bin/ruby
#This program is a deamo to recite word
require_relative "phrase.rb"
require_relative "control.rb"


app = Control.new
loop do
  app.run
end
