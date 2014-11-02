#!/usr/bin/env ruby -wKU
#
#
# Created on Nov 1 2014
# Author: Nallo 
#
#

require 'GraphBase'

class AhoCorasickNode < Node

    attr_reader   :output
    attr_accessor :failure

    def initialize(name="")
        super(name)
        @failure = 0
        @output  = []
    end

    def add_output(keyword)
        unless (not keyword) || (keyword.length==0)
            @output << keyword
        end
    end

    def goto(edge)
        unless (not edge) || (not edge)
            @edges[edge]
        end
    end    
end

class AhoCorasickGraph < Graph

    def initialize
        super
        add_node("root")
    end

    def add_node(with_name)
        unless ( not with_name ) ||
               ( with_name.length==0 if with_name.instance_of?(String) ) ||
               ( @nodes.has_key?(with_name) )
            @nodes[with_name] = AhoCorasickNode.new(with_name)
            @nodes_count += 1
        end
    end

    def add(needle)
        return nil if needle==nil

        puts "Processing #{needle}..."

        state = node("root")
        needle_index = 0
        
        while state.goto( needle[needle_index] )
            state = state.goto( needle[needle_index] )
            needle_index += 1
        end

        new_state = nodes_count

        needle_index.upto(needle.length - 1) { |i|
            add_node(new_state)
            add_edge(state.name, new_state, needle[i])
            state = node(new_state)
            new_state += 1
        }
        state.add_output(needle)
    end

    # def compute_aho_corasick_failure()
    #     queue = []

    #     node(0).edges.each do |first_level_neighbor|
    #         neighbor_id = first_level_neighbor[0]
    #         queue      << node( neighbor_id )
    #         # we do not need to set f(first_level_neighbor) to 0
    #         # because it is done by the default constructor.
    #     end

    #     while queue.size > 0 do
    #         r = queue.shift

    #         r.neighbors.each do |r_neighbor|
    #             r_neighbor_id   = r_neighbor[0]
    #             r_neighbor_edge = r_neighbor[1]
    #             queue << node( r_neighbor_id )
    #             state  = r.failure

    #             while state!=0 && node(state).goto(r_neighbor_edge)==nil
    #                 state =  node(state).failure
    #             end
                
    #             if node(state).goto(r_neighbor_edge)
    #                 node(r_neighbor_id).failure=(node(state).goto(r_neighbor_edge))
    #             end

    #             s = node(r_neighbor_id).failure

    #             output1 = node(r_neighbor_id).output
    #             output2 = node(      s      ).output
    #             node(r_neighbor_id).output=( output1 |= output2 )
    #         end
    #     end
    # end

    def has?(needle)
        return false if needle==nil

        state = node("root")
        index = 0

        index.upto(needle.length - 1){ |i|
            c = needle[i]

            if(not state.has_edge?(c))
                return false
            end

            state = state.goto(c)
            #puts "- #{state.name}"
        }
        return state.output.include?(needle)
    end

    def display_graph
        @nodes.values.each do |n|
            puts "Node #{n.name}"
            puts  " --> #{n.edges}"   if n.edges.size  > 0
            puts  " --> #{n.output}"  if n.output.size > 0
            puts  " --> #{n.failure}" if n.failure    != 0
            puts
        end
    end
end
