#!/usr/bin/env ruby -wKU


require_relative 'Haystack.rb'

#t1 = Text.new("he\nshe\nhis\nhers\npaperino")

puts "Loading keywords file..."

t1 = Haystack.new()

lines = File.readlines("../keywords-en.txt").map(&:strip)
puts lines.length

lines.each do |needle|
    t1.add(needle)
end

puts "Loading completed"

# t1.add("a")
# t1.add("aah")
# t1.add("aahed")
# t1.add("aahing")
# t1.add("aahs")
# t1.add("aardvark")
# t1.add("aardvarks")

puts "true #{t1.has?("bruce")}"
puts "true #{t1.has?("bristle")}"
puts "true #{t1.has?("britons")}"
puts "true #{t1.has?("breathable")}"
puts "true #{t1.has?("acolytes")}"
puts "true #{t1.has?("acknowledges")}"
puts "true #{t1.has?("acknowledgments")}"

puts "false #{t1.has?("acknowledgmentsterter")}"
puts "false #{t1.has?("stefano")}"
puts "false #{t1.has?("acquiescesqwerty")}"
puts "false #{t1.has?("adjustmentyrtytrqrew")}"
puts "false #{t1.has?("adjutancyuyiuyretw")}"
puts "false #{t1.has?("adjudicaturetrssdfg")}"
