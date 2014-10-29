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
	# * +list_of_keywords+ The plain text composed by a sequence of words.
	# The sequence of words is a list of strings.
	#
	def initialize(list_of_keywords)
		@haystack_graph = Graph.new()
		@haystack_graph.build_aho_corasick_graph!(list_of_keywords)
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
		@haystack_graph.find(needle)
	end

	# Display the Aho-Corasick Graph
	#
	def display_result
		@haystack_graph.display_graph
	end

end