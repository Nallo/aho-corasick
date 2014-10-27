#!/usr/bin/env ruby -wKU
#
#
# Created on Oct 27 2014
# Author: Nallo 
#
#
require_relative 'Graph.rb'

class Text

	# Initialize a new Haystack
	#
	# ==== Attributes
	#
	# * +plain_text+ The plain text composed by a sequence of words.
	# The sequence of words can be separated by whitespace, new line or
	# can be a list of words without whitespace.
	#
	def initialize(plain_text)
		if plain_text.instance_of?(String)
			plain_text = plain_text.split("\s")
		end

		@haystack_graph = Graph.new()
		@haystack_graph.build_aho_corasick_graph!(plain_text)
	end

	# Search the Needle into the Haystack
	#
	# ==== Attributes
	#
	# * +needle+ The Needle to search.
	#
	# ==== Return
	#
	# * +true+  if the Needle exists
	# * +false+ otherwise
	#
	def find(needle)
		puts "Find"
	end

	# Display the Aho-Corasick Graph
	#
	def display_result
		@haystack_graph.display_graph
	end

end