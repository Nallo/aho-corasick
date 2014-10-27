#!/usr/bin/env ruby -wKU

require_relative 'Text.rb'

t1 = Text.new("he\nshe\nhis\nhers")
t2 = Text.new("he she his hers")
t3 = Text.new(["he", "she", "his", "hers"])

t1.display_result()
t2.display_result()
t3.display_result()

#TBD
#t1.find("needle")
