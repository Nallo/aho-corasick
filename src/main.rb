#!/usr/bin/env ruby -wKU

require_relative 'Graph.rb'

#puts "Keywords"
keywords = []
keywords << "he"
keywords << "she"
keywords << "his"
keywords << "hers"
#puts keywords
#puts

g2 = Graph.new()
g2.build_aho_corasick_graph!(keywords)
g2.display_graph

lines = []
File.open("../keywords-en.txt", "r") do |file|
	while line = file.gets
		lines << line
	end
end

bigGraph = Graph.new()
bigGraph.build_aho_corasick_graph!(lines)