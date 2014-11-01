#!/usr/bin/env ruby -wKU
#
#
# Created on Oct 27 2014
# Author: Nallo 
#
#

require_relative 'AhoCorasickGraph.rb'

class Haystack

    def initialize
        @g = AhoCorasickGraph.new()
    end

    def add(needle)
        return nil if needle==nil
        @g.add(needle)
    end

    def has?(needle)
        @g.has?(needle)
    end

    def find_all(long_needle)
    end

    def display_graph
        @g.display_graph
    end

end

h = Haystack.new()
h.add("he")
h.add("she")
h.add("his")
h.add("hers")
puts h.has?("he")