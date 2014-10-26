#!/usr/bin/env ruby -wKU

require_relative 'Graph.rb'

puts "Keywords"
keywords = []
keywords << "he"
keywords << "she"
keywords << "his"
keywords << "hers"
puts keywords
puts

k2 = []
k2 << "pizza"
k2 << "papa"

g2 = Graph.new()
g2.build_aho_corasick_graph!(keywords)

g2.display_graph
