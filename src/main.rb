#!/usr/bin/env ruby -wKU


require_relative 'Haystack.rb'

#t1 = Text.new("he\nshe\nhis\nhers\npaperino")

puts "Loading keywords file..."
STDOUT.flush

lines = File.readlines("../keywords-en.txt").map(&:strip)
t1 = Haystack.new(lines)

puts "Loading completed"
STDOUT.flush

#input = gets.chomp
# t2 = Text.new("he she his hers")
# t3 = Text.new(["he", "she", "his", "hers"])

# t1.display_result()
# t2.display_result()
# t3.display_result()

v = t1.find("ah")
puts v
