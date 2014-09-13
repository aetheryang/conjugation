#!/usr/bin/ruby
#
# This program is a deamo to recite word
# Author  : aetheryang
# Mail    : aetheryang@gmail.com
# Copyright (c) 2014 aetheryang
#
require_relative "phrase.rb"
require_relative "control.rb"

app = Control.new
loop do
  app.run
end
