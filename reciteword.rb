#!/usr/bin/ruby
require_relative "phrase.rb"
require_relative "control.rb"


Phrase.num=1
a=Control.new
loop do
    a.word_first
    a.next
end
