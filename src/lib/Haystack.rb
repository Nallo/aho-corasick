#!/usr/bin/env ruby -wKU
#
#
# Created on Oct 27 2014
# Author: Nallo 
#
#

require 'AhoCorasickGraph'

class Haystack

    def initialize
        @g = AhoCorasickGraph.new()
    end

    def add_all(needles)
        return nil if needles==nil

        needles.each do |needle|
            @g.add(needle)
        end

        #@g.compute_failure()
    end

    def has?(needle)
        @g.has?(needle)
    end

    def query(needle)
        r = @g.has?(needle)
        if r
            puts "Haystack has \"#{needle}\""
        else
            puts "Haystack has NOT \"#{needle}\""
        end
    end

    def find_all(long_needle)
    end

    def display_graph
        @g.display_graph
    end

end