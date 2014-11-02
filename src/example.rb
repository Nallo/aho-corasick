#!/usr/bin/env ruby -wKU


require 'Haystack.rb'

# Create a new haystack
t1 = Haystack.new()

# Create a list of needles from file
# puts "Loading keywords file..."
# lines = File.readlines("../keywords-en.txt").map(&:strip)
# t1.add_all(lines)
# puts "Loading completed"

# Create a list of needles
# If using this option you have to comment the
# previous section "Create a list of needles from file"
needles = []
needles << "he"
needles << "she"
needles << "his"
needles << "hers"

# Add the needles to the haystack
t1.add_all(needles)


# Query the haystack
t1.query("he")
t1.query("she")
t1.query("hers")
t1.query("him")
t1.query("his")
t1.query("blablabla")
t1.query("does not exists")


# puts "true #{t1.has?("bruce")}"
# puts "true #{t1.has?("bristle")}"
# puts "true #{t1.has?("britons")}"
# puts "true #{t1.has?("breathable")}"
# puts "true #{t1.has?("acolytes")}"
# puts "true #{t1.has?("acknowledges")}"
# puts "true #{t1.has?("acknowledgments")}"

# puts "false #{t1.has?("acknowledgmentsterter")}"
# puts "false #{t1.has?("stefano")}"
# puts "false #{t1.has?("acquiescesqwerty")}"
# puts "false #{t1.has?("adjustmentyrtytrqrew")}"
# puts "false #{t1.has?("adjutancyuyiuyretw")}"
# puts "false #{t1.has?("adjudicaturetrssdfg")}"
